
##' writeGRANLog
##'
##' Utility function which writes gran logs
##' @param pkg The name of the package the log is about
##' @param msg The log message, collapsed if length>1
##' @param type "full", "error", or "both" indicating which log(s) the message
##' should be written to
##' @param logfile The location of the full log file to write/append to
##' @param errfile the location of the error log file to write/append to
##' @note This function is not intended for direct use by the end user.
##' @export
writeGRANLog = function(pkg, msg, type = "full", logfile, errfile)
{
    
    dt = date()
    targs = 
    
    if(type == "error")
    {
        targ = errfile
        err = " ERROR "
    } else if (type == "both") {
        targ = c(logfile, errfile)
        err = " ERROR "
    } else {
        targ = logfile
        err = character()
    }

    
    fullmsg = paste("\n",err, "pkg:", pkg, "(", dt, ") - ",
        paste(paste0("\t",msg), collapse="\n\t"))
    sapply(targ, function(x) cat(fullmsg, append=TRUE, file=x))
}

getPkgNames = function(path)
{
    path = normalizePath2(path)
    if(length(path) > 1)
        sapply(path, getPkgNames)
    if(file.info(path)$isdir && file.exists(file.path(path, "DESCRIPTION")))
        read.dcf(file.path(path, "DESCRIPTION"))[1,"Package"]
    else if (grepl(".tar", path, fixed=TRUE))
        gsub(basename(path), "([^_]*)_.*", "\\1")
}


getCheckoutLocs = function(codir, manifest = manifest_df(repo),
    branch = manifest$branch, repo)
{
    mapply(getPkgDir, basepath = codir, subdir = manifest$subdir,
           scm_type = manifest$type, branch = branch, name = manifest$name)
}

getMaintainers = function(codir, manifest = manifest_df(repo),
    branch = manifest$branch, repo) {
    sapply(getCheckoutLocs(codir, manifest = manifest), function(x) {
        if(!file.exists(file.path(x,"DESCRIPTION")))
            NA
        else {
            ## some github packages don't know how to construct
            ## DESCRIPTION files ... *mumble*
            tryCatch(read.dcf(file.path(x, "DESCRIPTION"))[,"Maintainer"],
                     error = function(x) NA)
        }
    })
}



isOkStatus = function(status= repo_results(repo)$status,
    repo)
{
    #status can be NA when the package isn't being built at all
    !is.na(status) & (status == "ok" | status == "ok - not tested" |
                      (check_warn_ok(repo) & status == "check warning(s)") |
                      (check_note_ok(repo) & status == "check note(s)"))
}

install.packages2 = function(pkgs, repos, ...)
{
    outdir = tempdir()
    wd = getwd()
    on.exit(setwd(wd))
    setwd(outdir)
    ## the keep_outputs=dir logic doesn't work, the files just
    ##end up in both locations!
    ##install.packages(pkgs, ..., keep_outputs=outdir)
    avail = available.packages(contrib.url(repos))
    install.packages(pkgs, repos, ..., keep_outputs=TRUE)
    ret = sapply(pkgs, function(p)
    {
        if(! p %in% avail[,"Package"])
            return("unavailable")
        fil = file.path(outdir, paste0(p, ".out"))
        tmp = readLines(fil)
        outcome = tmp[length(tmp)]
        if(grepl("* DONE", outcome, fixed=TRUE))
            "ok"
        else
            fil
    })
    ret
}


getBuilding = function(repo, results= repo_results(repo))
{
    results$building & isOkStatus( repo = repo)
}

getBuildingManifest = function(repo, results = repo_results(repo),
    manifest = manifest_df(repo))
{
    manifest[getBuilding(repo, results),]
}


getBuildingResults = function(repo, results = repo_results(repo))
{
    results[getBuilding(repo, results),]
}


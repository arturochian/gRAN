% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/AllClasses.R
\name{RepoBuildParam}
\alias{RepoBuildParam}
\title{RepoBuildParam}
\usage{
RepoBuildParam(basedir, repo_name = "current",
  temp_repo = file.path(basedir, repo_name, "tmprepo"),
  temp_checkout = file.path(basedir, "tmpcheckout"),
  errlog = file.path(basedir, repo_name, paste0("GRAN-errors-", repo_name,
  "-", Sys.Date(), ".log")), logfile = file.path(basedir, repo_name,
  paste0("GRAN-log-", repo_name, "-", Sys.Date(), ".log")),
  check_note_ok = TRUE, check_warn_ok = TRUE,
  tempLibLoc = file.path(basedir, repo_name, "LibLoc"),
  extra_fun = function(...) NULL, destination = basedir, auth = "",
  dest_url = paste0("file://", normalizePath2(destination)),
  shell_init = character(), logfun = function(...) writeGRANLog(..., logfile
  = logfile, errfile = errlog), install_test = TRUE, check_test = TRUE)
}
\arguments{
\item{basedir}{The base directory. By default the temporary repository,
temporary install library, and package staging area will be located in
<basedir>/<subrepoName>/, while the  temporary source checkout will be in t
he basedir itself.}

\item{repo_name}{The name of the repository, e.g. stable or devel}

\item{temp_repo}{Location to create the temporary repository}

\item{temp_checkout}{Location to create temporary checkouts/copies of package
source code}

\item{errlog}{The file to append error output to during the building and
testing processes}

\item{logfile}{The file to append summary log information to during building
and testing}

\item{check_note_ok}{logical. Whether packages that raise notes during
R CMD check should be considered to have passed}

\item{check_warn_ok}{logical. Whether packages that raise warnings during
R CMD check should be considered to have passed}

\item{tempLibLoc}{Location to create the temporary installed package library
for use during the testing process}

\item{extra_fun}{currently ignored}

\item{destination}{Base location (not including repository name) of the
final repository to be built}

\item{auth}{character. Authentication information required to add packages
to the manifest.}

\item{dest_url}{The base URL the destination directory corresponds to. The
subrepository name will be appended to this to generate the URL used when
installing from the repository.}

\item{shell_init}{An optional shell script to source before invoking system
commands, e.g. a bashrc file. Ignored if "" or not specified.}

\item{install_test}{logical. Should the install test be performed? Required
to build packages with vignettes, and for the check test}

\item{check_test}{logical. Should R CMD check be run on the packages as a
cohort. Requires install test.}

\item{manifest}{data.frame. The manifest of package information associated
with this repository. Defaults to an empty manifest.}
}
\description{
RepoBuildParam
}


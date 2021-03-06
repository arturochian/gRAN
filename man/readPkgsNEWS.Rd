% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/locateRisk.R
\name{readPkgsNEWS}
\alias{readPkgsNEWS}
\title{Read and summarize the NEWS files for packages at risk (updatable)}
\usage{
readPkgsNEWS(df, oldlib = .libPaths(), tmplib = file.path(tempdir(),
  "libloc"), repos = unique(df$Repository), newlib = NULL)
}
\arguments{
\item{df}{A data.frame or matrix of out-of-date packages currently installed, with columns Package, Installed (installed version), and Repository (contriburl of repo with newer version). Other columns are ignored. A}

\item{tmplib}{A temporary library directory to install new versions of the packages into so that their NEWS files can be accessed.}
}
\value{
A data.frame with 3 counts for each updatable package: bugfixes, u_visible_changes (user visible changes) and deprec (deprecation and defunct entries). All counts are NA if the package does not have parsable NEWS.
}
\description{
readPkgsNEWS
}
\details{
Attempts to generate a per-package summary of risky-to-ignore changes for updatable packages.
}


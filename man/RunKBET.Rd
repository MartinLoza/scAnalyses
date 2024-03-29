% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BatchCorrection.R
\name{RunKBET}
\alias{RunKBET}
\title{Title}
\usage{
RunKBET(
  object = NULL,
  batch = "batch",
  reduction = "pca",
  dims = 10,
  per = 0.1,
  acceptance = TRUE,
  verbose = FALSE
)
}
\arguments{
\item{object}{A seurat object to correct batch effects.}

\item{batch}{Batch labels.}

\item{reduction}{Reduction to use.}

\item{dims}{Number of dimensions to use.}

\item{per}{Percentages of the mean batch size.}

\item{acceptance}{Return the acceptance rate.}

\item{verbose}{Print verbose.}
}
\value{
kBET mean score.
}
\description{
Title
}

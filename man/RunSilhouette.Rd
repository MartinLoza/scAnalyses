% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BatchCorrection.R
\name{RunSilhouette}
\alias{RunSilhouette}
\title{RunSilhouette}
\usage{
RunSilhouette(object = NULL, batch = "celltype", reduction = "pca", dims = 10)
}
\arguments{
\item{object}{A seurat object to correct batch effects.}

\item{batch}{Batch labels.}

\item{reduction}{Reduction to use.}

\item{dims}{Number of dimensions to use.}
}
\value{
Silhouette width score.
}
\description{
RunSilhouette
}

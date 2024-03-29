% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DifferentialGeneExpression.R
\name{GetTopGenes}
\alias{GetTopGenes}
\title{GetTopGenes}
\usage{
GetTopGenes(
  deg = NULL,
  pval = 0.05,
  fold = 1.5,
  type = "double",
  ntop = NULL,
  group = NULL
)
}
\arguments{
\item{deg}{Data frame with DGE results.}

\item{pval}{P-value threshold.}

\item{fold}{Fold chagne threshold.}

\item{type}{Type of selected fold change. Available options are: "double", negatives and positive, "positive", and "negative".}

\item{ntop}{Number of top fold changes.}

\item{group}{If top. Group label to divide the data frame.}
}
\value{
Data frame with the top genes.
}
\description{
GetTopGenes
}

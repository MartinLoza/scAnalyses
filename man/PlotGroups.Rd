% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Visualization.R
\name{PlotGroups}
\alias{PlotGroups}
\title{PlotGroups}
\usage{
PlotGroups(
  object = NULL,
  group = NULL,
  combine = FALSE,
  ncol = 2,
  text_size = 20,
  point_size = 2,
  alpha = 1,
  low_color = "gray",
  high_color = "tomato",
  legend_position = "right",
  legend_point_size = NULL,
  order = TRUE,
  palette = NULL,
  ...
)
}
\arguments{
\item{object}{Seurat object with calculated UMAP}

\item{group}{Labels to use as colors.}

\item{combine}{Whether the plots should be combined}

\item{ncol}{If plots are combined, the number of columns of the final plot.}

\item{text_size}{Size of text.}

\item{point_size}{Size of points.}

\item{alpha}{Transparency of points.}

\item{low_color}{Color for background points.}

\item{high_color}{Color for main points.}

\item{legend_position}{Positions of plot legends.}

\item{legend_point_size}{Size of legends' points.}

\item{order}{Whether the points should be ordered.}

\item{palette}{Color pallete to use.}

\item{...}{Arguments passed to other methods.}
}
\value{

}
\description{
PlotGroups
}

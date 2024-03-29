% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_resample_result.R
\name{as_resample_result}
\alias{as_resample_result}
\alias{as_resample_result.ResampleResult}
\alias{as_resample_result.ResultData}
\alias{as_resample_result.list}
\title{Convert to ResampleResult}
\usage{
as_resample_result(x, ...)

\method{as_resample_result}{ResampleResult}(x, ...)

\method{as_resample_result}{ResultData}(x, view = NULL, ...)

\method{as_resample_result}{list}(x, task, learners, resampling, store_backends = TRUE, ...)
}
\arguments{
\item{x}{(any)\cr
Object to convert.}

\item{...}{(any)\cr
Currently not used.}

\item{view}{(\code{character()})\cr
See construction argument \code{view} of \code{\link{ResampleResult}}.}

\item{task}{(\link{Task}).}

\item{learners}{(list of trained \link{Learner}s).}

\item{resampling}{(\link{Resampling}).}

\item{store_backends}{(\code{logical(1)})\cr
If set to \code{FALSE}, the backends of the \link{Task}s provided in \code{data} are
removed.}
}
\value{
(\link{ResampleResult}).
}
\description{
Convert object to a \link{ResampleResult}.

The S3 method for \code{list} expects argument \code{x} to be a list of \link{Prediction} objects and
all other relevant objects (\link{Task}, \link{Learner}s, and instantiated \link{Resampling}) must
be provided, too.
A more flexible way to manually create a \link{ResampleResult} is implemented in \code{\link[=as_result_data]{as_result_data()}}.
}

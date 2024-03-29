% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_benchmark_result.R
\name{as_benchmark_result}
\alias{as_benchmark_result}
\alias{as_benchmark_result.BenchmarkResult}
\alias{as_benchmark_result.ResampleResult}
\title{Convert to BenchmarkResult}
\usage{
as_benchmark_result(x, ...)

\method{as_benchmark_result}{BenchmarkResult}(x, ...)

\method{as_benchmark_result}{ResampleResult}(x, ...)
}
\arguments{
\item{x}{(any)\cr
Object to convert.}

\item{...}{(any)\cr
Additional arguments.}
}
\value{
(\link{BenchmarkResult}).
}
\description{
Convert object to a \link{BenchmarkResult}.
}

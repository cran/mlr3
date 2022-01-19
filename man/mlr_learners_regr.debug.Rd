% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LearnerRegrDebug.R
\name{mlr_learners_regr.debug}
\alias{mlr_learners_regr.debug}
\alias{LearnerRegrDebug}
\title{Regression Learner for Debugging}
\description{
A simple \link{LearnerRegr} used primarily in the unit tests and for debugging purposes.
If no hyperparameter is set, it simply constantly predicts the mean value of the training data.
The following hyperparameters trigger the following actions:
\describe{
\item{predict_missing:}{Ratio of predictions which will be NA.}
\item{predict_missing_type:}{To to encode missingness. \dQuote{na} will insert NA values, \dQuote{omit} will just return fewer predictions than requested.}
\item{save_tasks:}{Saves input task in \code{model} slot during training and prediction.}
\item{threads:}{Number of threads to use. Has no effect.}
\item{x:}{Numeric tuning parameter. Has no effect.}
}
}
\section{Dictionary}{

This \link{Learner} can be instantiated via the \link[mlr3misc:Dictionary]{dictionary} \link{mlr_learners} or with the associated sugar function \code{\link[=lrn]{lrn()}}:\preformatted{mlr_learners$get("regr.debug")
lrn("regr.debug")
}
}

\section{Meta Information}{

\itemize{
\item Task type: \dQuote{regr}
\item Predict Types: \dQuote{response}, \dQuote{se}
\item Feature Types: \dQuote{logical}, \dQuote{integer}, \dQuote{numeric}, \dQuote{character}, \dQuote{factor}, \dQuote{ordered}
\item Required Packages: \CRANpkg{mlr3}
}
}

\section{Parameters}{
\tabular{lllll}{
   Id \tab Type \tab Default \tab Range \tab Levels \cr
   predict_missing \tab numeric \tab 0 \tab \eqn{[0, 1]}{[0, 1]} \tab - \cr
   predict_missing_type \tab character \tab na \tab - \tab na, omit \cr
   save_tasks \tab logical \tab FALSE \tab - \tab TRUE, FALSE \cr
   threads \tab integer \tab - \tab \eqn{[1, \infty)}{[1, Inf)} \tab - \cr
   x \tab numeric \tab - \tab \eqn{[0, 1]}{[0, 1]} \tab - \cr
}
}

\examples{
task = tsk("mtcars")
learner = lrn("regr.debug", save_tasks = TRUE)
learner$train(task, row_ids = 1:20)
prediction = learner$predict(task, row_ids = 21:32)

learner$model$task_train
learner$model$task_predict
}
\seealso{
\itemize{
\item Chapter in the \href{https://mlr3book.mlr-org.com/}{mlr3book}:
\url{https://mlr3book.mlr-org.com/basics.html#learners}
\item Package \CRANpkg{mlr3learners} for a solid collection of essential learners.
\item Package \href{https://github.com/mlr-org/mlr3extralearners}{mlr3extralearners} for more learners.
\item \link[mlr3misc:Dictionary]{Dictionary} of \link[=Learner]{Learners}: \link{mlr_learners}
\item \code{as.data.table(mlr_learners)} for a table of available \link[=Learner]{Learners} in the running session (depending on the loaded packages).
\item \CRANpkg{mlr3pipelines} to combine learners with pre- and postprocessing steps.
\item Package \CRANpkg{mlr3viz} for some generic visualizations.
\item Extension packages for additional task types:
\itemize{
\item \CRANpkg{mlr3proba} for probabilistic supervised regression and survival analysis.
\item \CRANpkg{mlr3cluster} for unsupervised clustering.
}
\item \CRANpkg{mlr3tuning} for tuning of hyperparameters, \CRANpkg{mlr3tuningspaces}
for established default tuning spaces.
}

Other Learner: 
\code{\link{LearnerClassif}},
\code{\link{LearnerRegr}},
\code{\link{Learner}},
\code{\link{mlr_learners_classif.debug}},
\code{\link{mlr_learners_classif.featureless}},
\code{\link{mlr_learners_classif.rpart}},
\code{\link{mlr_learners_regr.featureless}},
\code{\link{mlr_learners_regr.rpart}},
\code{\link{mlr_learners}}
}
\concept{Learner}
\section{Super classes}{
\code{\link[mlr3:Learner]{mlr3::Learner}} -> \code{\link[mlr3:LearnerRegr]{mlr3::LearnerRegr}} -> \code{LearnerRegrDebug}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{LearnerRegrDebug$new()}}
\item \href{#method-clone}{\code{LearnerRegrDebug$clone()}}
}
}
\if{html}{
\out{<details ><summary>Inherited methods</summary>}
\itemize{
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="base_learner">}\href{../../mlr3/html/Learner.html#method-base_learner}{\code{mlr3::Learner$base_learner()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="format">}\href{../../mlr3/html/Learner.html#method-format}{\code{mlr3::Learner$format()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="help">}\href{../../mlr3/html/Learner.html#method-help}{\code{mlr3::Learner$help()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="predict">}\href{../../mlr3/html/Learner.html#method-predict}{\code{mlr3::Learner$predict()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="predict_newdata">}\href{../../mlr3/html/Learner.html#method-predict_newdata}{\code{mlr3::Learner$predict_newdata()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="print">}\href{../../mlr3/html/Learner.html#method-print}{\code{mlr3::Learner$print()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="reset">}\href{../../mlr3/html/Learner.html#method-reset}{\code{mlr3::Learner$reset()}}\out{</span>}
\item \out{<span class="pkg-link" data-pkg="mlr3" data-topic="Learner" data-id="train">}\href{../../mlr3/html/Learner.html#method-train}{\code{mlr3::Learner$train()}}\out{</span>}
}
\out{</details>}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
Creates a new instance of this \link[R6:R6Class]{R6} class.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{LearnerRegrDebug$new()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{LearnerRegrDebug$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
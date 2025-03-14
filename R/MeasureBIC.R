#' @title Bayesian Information Criterion Measure
#'
#' @name mlr_measures_bic
#' @include Measure.R
#'
#' @description
#' Calculates the Bayesian Information Criterion (BIC) which is a
#' trade-off between goodness of fit (measured in terms of
#' log-likelihood) and model complexity (measured in terms of number
#' of included features).
#' Internally, [stats::BIC()] is called.
#' Requires the learner property `"loglik"`, `NA` is returned for unsupported learners.
#'
#' @templateVar id bic
#' @template measure
#'
#' @template seealso_measure
#' @export
MeasureBIC = R6Class("MeasureBIC",
  inherit = Measure,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      super$initialize(
        id = "bic",
        task_type = NA_character_,
        properties = c("na_score", "requires_learner", "requires_model", "requires_no_prediction"),
        predict_sets = NULL,
        predict_type = NA_character_,
        minimize = TRUE,
        label = "Bayesian Information Criterion",
        man = "mlr3::mlr_measures_bic"
      )
    }
  ),

  private = list(
    .score = function(prediction, learner, ...) {
      learner = learner$base_learner()

      tryCatch({
        return(stats::BIC(stats::logLik(learner$model)))
      }, error = function(e) {
        warningf("Learner '%s' does not support BIC calculation", learner$id)
        return(NA_real_)
      })
    }
  )
)

#' @include mlr_measures.R
mlr_measures$add("bic", function() MeasureBIC$new())

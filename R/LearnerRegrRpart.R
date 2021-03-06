#' @title Regression Tree Learner
#'
#' @name mlr_learners_regr.rpart
#' @include LearnerRegr.R
#'
#' A [LearnerRegr] for a regression tree implemented in [rpart::rpart()] in package \CRANpkg{rpart}.
#' @description
#' Parameter `xval` is set to 0 in order to save some computation time.
#' Parameter `model` has been renamed to `keep_model`.
#'
#' @templateVar id regr.rpart
#' @template section_dictionary_learner
#'
#' @section Meta Information:
#' `r rd_info(lrn("regr.rpart"))`
#'
#' @section Parameters:
#' `r rd_info(lrn("regr.rpart")$param_set)`
#'
#' @references
#' `r format_bib("breiman_1984")`
#'
#' @template seealso_learner
#' @export
LearnerRegrRpart = R6Class("LearnerRegrRpart", inherit = LearnerRegr,
  public = list(
    #' @description
    #' Creates a new instance of this [R6][R6::R6Class] class.
    initialize = function() {
      ps = ParamSet$new(list(
        ParamInt$new(id = "minsplit", default = 20L, lower = 1L, tags = "train"),
        ParamInt$new(id = "minbucket", lower = 1L, tags = "train"),
        ParamDbl$new(id = "cp", default = 0.01, lower = 0, upper = 1, tags = "train"),
        ParamInt$new(id = "maxcompete", default = 4L, lower = 0L, tags = "train"),
        ParamInt$new(id = "maxsurrogate", default = 5L, lower = 0L, tags = "train"),
        ParamInt$new(id = "maxdepth", default = 30L, lower = 1L, upper = 30L, tags = "train"),
        ParamInt$new(id = "usesurrogate", default = 2L, lower = 0L, upper = 2L, tags = "train"),
        ParamInt$new(id = "surrogatestyle", default = 0L, lower = 0L, upper = 1L, tags = "train"),
        ParamInt$new(id = "xval", default = 10L, lower = 0L, tags = "train"),
        ParamLgl$new(id = "keep_model", default = FALSE, tags = "train")
      ))
      ps$values = list(xval = 0L)

      super$initialize(
        id = "regr.rpart",
        feature_types = c("logical", "integer", "numeric", "factor", "ordered"),
        predict_types = "response",
        packages = "rpart",
        param_set = ps,
        properties = c("weights", "missings", "importance", "selected_features"),
        man = "mlr3::mlr_learners_regr.rpart"
      )
    },

    #' @description
    #' The importance scores are extracted from the model slot `variable.importance`.
    #' @return Named `numeric()`.
    importance = function() {
      if (is.null(self$model)) {
        stopf("No model stored")
      }
      # importance is only present if there is at least on split
      sort(self$model$variable.importance %??% set_names(numeric()), decreasing = TRUE)
    },

    #' @description
    #' Selected features are extracted from the model slot `frame$var`.
    #' @return `character()`.
    selected_features = function() {
      if (is.null(self$model)) {
        stopf("No model stored")
      }
      setdiff(self$model$frame$var, "<leaf>")
    }
  ),

  private = list(
    .train = function(task) {
      pv = self$param_set$get_values(tags = "train")
      names(pv) = replace(names(pv), names(pv) == "keep_model", "model")
      if ("weights" %in% task$properties) {
        pv = insert_named(pv, list(weights = task$weights$weight))
      }

      invoke(rpart::rpart, formula = task$formula(), data = task$data(), .args = pv, .opts = allow_partial_matching)
    },

    .predict = function(task) {
      newdata = task$data(cols = task$feature_names)
      response = invoke(predict, self$model, newdata = newdata, .opts = allow_partial_matching)
      list(response = unname(response))
    }
  )
)

#' @include mlr_learners.R
mlr_learners$add("regr.rpart", LearnerRegrRpart)

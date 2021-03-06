test_that("re-instantiating", {
  t1 = tsk("iris")
  t2 = tsk("boston_housing")
  r = rsmp("cv", folds = 2)

  expect_resampling(r$instantiate(t1), task = t1)
  expect_resampling(r$instantiate(t2), task = t2)

  r = rsmp("custom")
  expect_error(r$instantiate(t1), "missing")

  expect_resampling(r$instantiate(t1, train_sets = list(1), test_sets = list(1)), task = t1)
  expect_resampling(r$instantiate(t2, train_sets = list(1), test_sets = list(2)), task = t2)
})

test_that("param_vals", {
  task = tsk("iris")
  r = rsmp("bootstrap", repeats = 100L, ratio = 1)

  expect_identical(r$param_set$values$ratio, 1)
  expect_identical(r$param_set$values$repeats, 100L)

  r$instantiate(task)
  expect_true(r$is_instantiated)
  expect_identical(r$iters, 100L)
  expect_integerish(r$train_set(100), len = task$nrow)

  expect_resampling(r)

  expect_error({
    r$param_set$values = list(repeats = 10L)
    r$param_set$get_values()
  }, "ratio")

  expect_error({
    r$param_set$values = list(ratio = 0.5, repeats = 10L, foobar = 12)
  }, "foobar")
})

test_that("hashing", {
  task = tsk("iris")
  keys = setdiff(mlr_resamplings$keys(), c("custom", "ordered_holdout"))

  for (key in keys) {
    r = rsmp(key)

    with_seed(123L, r$instantiate(task))
    hash = r$hash
    expect_string(hash, pattern = "^[a-z0-9]+$")

    with_seed(123L, r$instantiate(task))
    expect_identical(r$hash, hash)

    if (key != "insample") {
      with_seed(124L, r$instantiate(task))
      expect_false(identical(r$hash, hash))
    }
  }
})

test_that("cloning", {
  task = tsk("iris")
  keys = setdiff(mlr_resamplings$keys(), c("custom", "ordered_holdout"))

  for (key in keys) {
    r = rsmp(key)$instantiate(task)

    clone = r$clone(deep = TRUE)
    expect_different_address(r$param_set, clone$param_set)
    if (is.data.table(r$instance))
      expect_different_address(r$instance, clone$instance)
  }
})

test_that("integer grouping col (#396)", {
  df = data.frame(
    id = rep(1L:10L, each = 2),
    x = rnorm(20)
  )

  tsk = TaskRegr$new(id = "task", backend = df, target = "x")
  tsk$set_col_roles("id", "group")

  bs = rsmp("bootstrap", repeats = 10L, ratio = 1)
  bs$instantiate(tsk)

  set = bs$train_set(1)
  expect_integer(set)
  expect_true(all(map_lgl(split(seq_row(df), f = df$id), function(x) all(x %in% set) || all(x %nin% set))))

  set = bs$test_set(1)
  expect_integer(set)
  expect_true(all(map_lgl(split(seq_row(df), f = df$id), function(x) all(x %in% set) || all(x %nin% set))))
})

test_that("as.data.table.Resampling", {
  r = rsmp("bootstrap")
  r$instantiate(tsk("mtcars"))

  tab = as.data.table(r)
  expect_data_table(tab, ncols = 3)
  expect_names(names(tab), permutation.of = c("set", "iteration", "row_id"))
  expect_integer(tab$iteration, any.missing = FALSE)
  expect_factor(tab$set, levels = c("train", "test"), any.missing = FALSE)
  expect_integer(tab$row_id, any.missing = FALSE)
})

test_that("Evaluation on validation set", {
  task = tsk("sonar")
  rids = task$row_ids
  task$row_roles$validation = tail(rids, 10)
  task$row_roles$use = head(rids, -10)
  learner = lrn("classif.rpart", predict_sets = c("test", "validation"))
  rr = resample(task, learner, rsmp("holdout"))

  m1 = msr("classif.acc", id = "acc.test", predict_sets = "test")
  m2 = msr("classif.acc", id = "acc.holdout", predict_sets = "validation")

  expect_equal(rr$aggregate(list(m1, m2)), c(rr$prediction("test")$score(m1), rr$prediction("validation")$score(m2)))
})

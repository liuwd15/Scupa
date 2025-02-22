% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_training.R
\name{CalculateParams}
\alias{CalculateParams}
\title{Train machine learning models and calculating parameters}
\usage{
CalculateParams(
  object,
  embedding = "uce",
  pc = 1:20,
  classify_method = "svc",
  calibration_fold = 5,
  semi_supervised = FALSE,
  verbose = TRUE
)
}
\arguments{
\item{object}{A Seurat object of a cell type from the Immune Dictionary.}

\item{embedding}{The name of embedding saving the cell embeddings from the single-cell
foundation model in the Seurat object. Default: UCE.}

\item{pc}{The index of principal component as predictor variables for training
machine learning models. Default: 1:20.}

\item{classify_method}{A string from one of 'logistic','svc','svr','rf'. The
machine learning models to classify polarized cells and unpolarized cells.
Default: svr.}

\item{calibration_fold}{A number of folds for splitting data in conformal prediction,
similar as K-fold cross validation. Default: 5.}

\item{semi_supervised}{Logical. Whether to use the semi-supervised approach in
training machine learning models. If TRUE, the unlabeled cells from samples
treated with non-driving cytokines are used to train the final output machine
learning models. Default: FALSE.}

\item{verbose}{Whether to message the progress in different polarization states.
Default: TRUE.}
}
\value{
A list containing 6 variables:
\describe{
\item{mean}{The mean of Universial Cell Embeddings of all cells in the training
dataset.}
\item{sd}{The standard deviation of Universial Cell Embeddings of all cells
in the training dataset.}
\item{mean_unpolar}{The mean of Universial Cell Embeddings of unpolarized cells
in the training dataset.}
\item{pc_loadings}{The principal component loadings to transform Universial
Cell Embeddings into principal component embeddings.}
\item{models}{The trained machine learning models to predict the
polarization scores based on principal component embeddings for each cell
polarization state.}
\item{unpolar_responses}{The polarization scores of unpolarized cells in the
training dataset. The probability of input data being unpolarized is calculated
by comparing to the distribution of these responses.}
\item{calibration_quantiles}{The 1~99 quantiles of nonconformity scores in
calibration data, used for conformal prediction.}
}
}
\description{
Train machine learning models and calculating some necessary parameters to
measure immune cell polarization. Conformal prediction is employed to make
statistically valid predictions. The models are trained using the output from
\code{AssignStates}.
}
\details{
Run this function only if you want to retrain the models using custom parameters!
}
\examples{
\dontrun{
# Please download the Immune Dictionary data at
cd8t <- AssignStates(cd8t, polar_states_cd8t, dist_thres=0.85)
polar_params_cd8t <- CalculateParams(cd8t, classify_method='svr')
}

}
\seealso{
Logistic regression model: \code{\link[stats]{glm}} with parameter: family = 'binomial'.

SVC model: \code{\link[e1071]{svm}} with parameter: kernel='linear'.

SVR model: \code{\link[e1071]{svm}} with parameters: kernel='linear', type='eps-regression'.

Random forest model: \code{\link[randomForest]{randomForest}} with default parameters.
}

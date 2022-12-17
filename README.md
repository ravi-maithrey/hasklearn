# About

This repo contains code for a machine learning library written in Haskell. The main reason for it's existence is to serve as a proof of concept for implementing Machine Learning in Haskell. Issues and limitations are discussed [below](#Issues). For installation instructions check - [Installation](#Installation). 

## Contents

As of December 2022, this library has methods for Linear and Logistic Regression, KNN and Naive Bayes. The idea is for this library to be as close of an approximation of sklearn in python as possible. 

## Implementation Details

### General

This library does not define any monads of its own. (Technically, that is false, as there is a single monad defined in here. However, that defintion only type checks, but does not produce any valid output). 

Every implementation is from scratch i.e., no external libraries have been used. The State Monad has been used to keep track of the weights and biases while training for linear and logistic regression. KNN uses `Data.Ord` and `Data.List` for comparsions between neighbours. Everything has been defined from `Base`.

### Linear and Logistic Regression

A new datatype called `Model` has been defined to store the weights and biases of the model. In order to train, stochastic gradient descent has been used. It runs the algorithm for a fixed number of iterations which are passed in as a parameter to the training function. 

### KNN 

Distance metric used is Euclidean Distance. In a future version, might upgrate to Minkowski Distance with apprpriate `p` value.

### Naive Bayes

The `Data` datatype keeps track of corresponding input and output datapoints to calculate the requisite probabilities. Each probability is calculated as a discrete value. While the general idea is to use a distribution (Gaussian, for example), for our present purposes, this serves the same purpose in theory.

# Installation

This library is not on stack/cabal/hackage. Download the repo as is to the folder of your choice using `git clone`. Then, add the file you wish to import into your `.cabal` file and import it in the file you wish to use it in. Check [Usage](#Usage) for more details.

A sample `.cabal` file is below. It only shows the relavant portions. You must have the files in the correct path within the folder where this cabal project is present for it to work.

```yaml
    other-modules: Model,
                   Logistic,
                   KNN,
                   Naive

    build-depends: base >=4.14.3.0, 
                   mtl 
```
The project was built with `base >= 4.14.3.0`, but you can use any version as long as it doesn't have breaking changes from this version.

# Usage

## Linear Regression
```haskell
import Model

-- initialize the model
linReg = linearReg xsTrs ysTrs
-- training with xsTrs and ysTrs as training set and 1000 iterations
-- this returns a trained model instance
linReg' = converge linReg xsTrs ysTrs 1000
-- predicting with xsTe as test set
ysTe = predict xsTe linReg'
```
## KNN
```haskell
-- initialize the model
knn' = knn xsTrs ysTrs
-- predict on new instances
ys = knnFit knn' xsTest 5 -- the last parameter is for k
```
# Issues and Limitations


1. The original conception of the library was one which would have a monad for the `Model` datatype. This would allow for iterative computation/training. My knowledge of Haskell was not high enough for me to do this.
1. The Naive Bayes method described in this library does not treat the data points as having parameters but instead works off of the assumption that each input point is a unique value itself. This leads to wonky values of the calculated probabilites
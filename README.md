# About

This repo contains code for a machine learning library written in Haskell. The main reason for it's existence is to serve as a proof of concept for implementing Machine Learning in Haskell. Issues and limitations are discussed [below](#Issues). For installation instructions check - [Installation](#Installation). 

## Contents

As of December 2022, this library has methods for Linear and Logistic Regression, KNN and Naive Bayes. The idea was to be as close of an approximation of sklearn in python as possible. 

## Implementation Details

### General

This library does not define any monads of its own. (Technically, that is false, as there is a single monad defined in here. However, that defintion only type checks, but does not produce any valid output). 

Every implementation is from scratch i.e., no external libraries have been used. The State Monad has been used to keep track of the weights and biases while training for linear and logistic regression. KNN uses `Data.Ord` and `Data.List` for comparsions between neighbours. Everything has been defined from `Base`.

### Linear and Logistic Regression

A new datatype called `Model` has been defined to store the weights and biases of the model. In order to train, stochastic gradient descent has been used. It runs the algorithm for a fixed number of iterations which are passed in as a parameter to the training function. 

### KNN 

Distance metric used is Euclidean Distance. In a future version, might upgrate to Minkowski Distance with apprpriate `p` value.

### Naive Bayes

The `Data` datatype keeps track of corresponding input and output datapoints to calculate the requisite probabilities. Each probability is 

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

```haskell
Placeholder
```

# Issues and Limitations

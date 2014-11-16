# Introduction

This is the Codebook for the Getting and Cleaning Data Course Project

# Source Dataset

The Codebook for the source dataset can be found here:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Code Variables

datafile - name of the ZIP file containing the data

datadir - location of the ZIP file on my own PC

test dir - directory to be added to contain the test data

train dir - directory to be added to contain the training data

subject_train - column subjects for the training dataset

subject_test - column subjects for the test dataset

feature_name - feature names from the datasets

train_y - training y values less leading/trailing white space

test_y - test y values less leading/trailing white space

train_x - training x values less leading/trailing white space

test_x - test x values less leading/trailing white space

keep_features - names of mean or std vatables used to caculate values to be kept 

train - data wanted for training

test - data wanted for testing

combined - merge of train and test data

column_headers - column names of the features we are keeping

means - tidy dataset of verage values

#Method

Create varables and directories for the data.

Load required packages.

Download the ZIP file of data from this location: https://d396qusza40orc.cloudfron
t.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the file.

Merge the datasets removing the white space.

Work out the columns to keep with the average data

wite out the average values to a text file.

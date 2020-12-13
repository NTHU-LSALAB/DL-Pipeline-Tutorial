#!/bin/bash

version=$(ls -1 ~/saved_model/input_models | wc -l)
(( version = version -1 ))
rm ./output_v$version*
rm -f ~/top_model_weights_$version.h5
rm -rf ~/saved_model/x_test/$version

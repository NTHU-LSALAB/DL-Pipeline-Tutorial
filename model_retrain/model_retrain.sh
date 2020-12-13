#!/bin/sh

mv ~/photos/dog/* ~/model_retrain/data/train/dog/
mv ~/photos/cat/* ~/model_retrain/data/train/cat/

version=$(ls -1 ~/saved_model/input_models | wc -l) # The model gonna be trained is the verison $version
# echo Model version is: $version
python3 retrain.py data model | tee output_v$version
sleep 5
accuracy=$(cat output_v$version | tail -n 3 | head -n 1 | awk '{print $11}')
# echo Accuracy is: $accuracy
mv output_v$version output_v$version\_$accuracy

saved_model_input="~/saved_model/input_models/top_model_weights_$version.h5"
saved_model_output="~/saved_model/x_test/$version"
cp ~/model_retrain/model/top_model_weights.h5 $saved_model_input
python3 ~/saved_model/export_saved_model.py $saved_model_input $saved_model_output

sleep 10
echo "Done!!! This is model version $version"


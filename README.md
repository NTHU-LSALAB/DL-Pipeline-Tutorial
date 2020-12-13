# DL-Pipeline-Tutorial
![image](https://github.com/lsalab-member/DL-Pipeline-Tutorial/blob/main/system.png)
![image](https://github.com/lsalab-member/DL-Pipeline-Tutorial/blob/main/螢幕快照%202020-12-06%20下午11.01.56.png)

## <h2> Environment
- Python        3.8.5       
`sudo apt-get install python3` 
- pip3          20.3.1      
`sudo apt-get install python3-pip`
- Tensorflow    2.3.1
`pip3 install tensorflow`
- Keras         2.4.3      
`pip3 install keras`
- Docker        `Make sure that you have been installed!!`
- Kubenetes     `Make sure that you have been installed!!`

## <h2> Command Tutorial
![image](https://github.com/lsalab-member/DL-Pipeline-Tutorial/blob/main/tutorial.png)
## <h3> Part one: 
`cd`
`wget "https://drive.google.com/drive/u/0/my-drive?fbclid=IwAR2xzfwN0Ef7QlVbiPcoLL5YU-e1lIYtMOYbl0o-T-d3bHOXy-W6_tIA55I/%3Ffbclid=IwAR2pzCu3AeADcJmDDIjsBmlpSjc33BYZgzlh02ykJ_w4VeZhqFcz4KHaCpE" -O "top_model_weights.h5"`

-`model_retrain/retrain.sh`


- Data is located at `model_retrain/data/`.
- `model_retrain/retrain.py` generates a new model at `model_retrain/model/`.
- Write the trainging log to file `output_<version>_<accuracy>`.This file is used to serve the website, which needs information about the model to display.
- After training a new model, the `.h5` file is copied to `saved_model/input_models/`.
- `saved_model/export_saved_model.py` generate saved model to `saved_model/x_test/`.

## <h3> Part two: 
`model_retrain/model_remove_bad_perf.sh`
If the newest model's performance is low, you may remove it with this script.

## <h3> Part three: 
`model_retrain/model_deploy.sh`
- Deploy a specific version model to the cluster. It writes a new yaml file at `deploy/tfserving_<version>.yml` and creates a new pod.

## <h3> Part four:
`model_retrain/model_delete.sh`
- Remove specific version of TF serving pod.

## <h2> Overall Command
1.`model_retrain/retrain.sh`

2.`model_retrain/model_remove_bad_perf.sh`

3.`model_retrain/model_delete.sh`

4.`model_retrain/model_delete.sh`


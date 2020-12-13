# DL-Pipeline-Tutorial
![image](https://github.com/lsalab-member/DL-Pipeline-Tutorial/blob/main/system.png)
![image](https://github.com/lsalab-member/DL-Pipeline-Tutorial/blob/main/螢幕快照%202020-12-06%20下午11.01.56.png)

## <h2> Environment
- Python        3.6.9       
`sudo apt-get install python3` 
- pip3          20.3.1      
`sudo apt-get install python3-pip`
`pip3 install --upgrade pip`
- Tensorflow    1.15.0
`pip3 install tensorflow==1.15.0`
- Keras         2.3.1      
`pip3 install keras==2.3.1`
- Docker        `Make sure that you have been installed!!`
- Kubenetes     `Make sure that you have been installed!!`

## <h2> Command Tutorial
![image](https://github.com/lsalab-member/DL-Pipeline-Tutorial/blob/main/tutorial.png)
## <h3> Part one: 
`cd $HOME/DL-Pipeline-Tutorial/model_retrain/model`
`wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1zwrqgdkeHkxU7mwMHTtidkPK_10kNAW7' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1zwrqgdkeHkxU7mwMHTtidkPK_10kNAW7" -O top_model_weights.h5&& rm -rf /tmp/cookies.txt`

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
`cd $HOME/DL-Pipeline-Tutorial/model_retrain/model`
`wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1zwrqgdkeHkxU7mwMHTtidkPK_10kNAW7' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1zwrqgdkeHkxU7mwMHTtidkPK_10kNAW7" -O top_model_weights.h5&& rm -rf /tmp/cookies.txt`

1.`model_retrain/retrain.sh`

2.`model_retrain/model_deploy.sh`

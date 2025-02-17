# MetaLadder
The code for paper **"MetaLadder: Ascending Mathematical Solution Quality via Analogical-Problem Reasoning Transfer"**.

## Setup

```
conda create -n metaladder python=3.11
conda activate metaladder
pip install -r requirements.txt
```
## Data
All data can be found in `./data`, include original CoT data, MetaLadder-enhanced data, MetaLadder+Reverse data, RefAug-augmented data, MetaMath data, AugCoT data.

## Train
1. Clone LLaMA-Factory.
    ```
    git clone https://github.com/hiyouga/LLaMA-Factory
    ``` 

2. Add config of trainsets in `./LLaMA-Factory/data/dataset_info.sh` and the training prompt in `./LLaMA-Factory/src/llamafactory/data/template.py`.
3. Run `bash train.sh`.


## Test
- For normal test, run `bash test.sh`.
- For shortcut inference, run `bash shortcut.sh`.

## Self-evolution
1. Run `bash sample.sh` for data-sampling. For sampling on reversed data, run `bash reverse_sample.sh`.
2. Append sampled data to original data.
3. Train the base model by `bash train.sh`.
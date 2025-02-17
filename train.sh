#!/bin/bash

source activate metaladder
cd ./LLaMA-Factory
START_TIME=`date +%Y%m%d-%H:%M`

N_EPOCH=1
model_names=(
    "meta-llama/Meta-Llama-3-8B"
)
deepspeed_configs=(
    "examples/deepspeed/ds_z2_config.json"
)
data_paths=(
    cot
    refaug
    analogyaug
    metaladder
    metaladder_reverse
)
template="math"

for i in "${!model_names[@]}"; do
    base_model_name=${model_names[$i]}
    ds_config=${deepspeed_configs[0]}
    for dataset_name in "${data_paths[@]}"; do
        pkill sft_lr
        llamafactory-cli train \
            --stage sft \
            --do_train True \
            --model_name_or_path ${base_model_name} \
            --preprocessing_num_workers 16 \
            --finetuning_type full \
            --template ${template} \
            --flash_attn fa2 \
            --dataset_dir data \
            --dataset ${dataset_name} \
            --cutoff_len 4096 \
            --learning_rate 5e-06 \
            --num_train_epochs ${N_EPOCH} \
            --max_samples 400000 \
            --per_device_train_batch_size 4 \
            --gradient_accumulation_steps 4 \
            --lr_scheduler_type cosine \
            --max_grad_norm 1.0 \
            --logging_steps 5 \
            --save_steps 10000000 \
            --warmup_steps 0 \
            --optim adamw_torch \
            --packing False \
            --report_to none \
            --output_dir sft-models/${base_model_name}/${dataset_name}_${N_EPOCH}epoch/${START_TIME} \
            --bf16 True \
            --plot_loss True \
            --ddp_timeout 280000000 \
            --include_num_input_tokens_seen True \
            --deepspeed ${ds_config}  \
            --save_only_model
    done
done

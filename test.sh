source activate metaladder

export PROJECT_HOME=./evaluation
cd ${PROJECT_HOME}

PROMPT_TYPE="cot-meta-math"


export CUDA_VISIBLE_DEVICES="0"
MODEL_NAME_OR_PATH="path/to/checkpoint"

bash sh/eval.sh $PROMPT_TYPE $MODEL_NAME_OR_PATH
#!/bin/bash
echo "Params" $1 $2 $3 $4 $5 $6
# usual split 1 3 6 13

python evaluate_demo.py --model vgg16 \
                        --model_weights $5 \
                        --dataset imagenet \
                        --data_dir $3 \
                        --batches_per_train 10000000 \
                        --batches_per_val 10000000 \
                        --batch_size 64 \
                        --save_dir $4 \
                        --conv_split $6 \
                        --validate_before_ft \
                        --ft_epochs 20 \
                        --patience 3 \
                        --compress_iters 8 \
                        --gpu_number $1 \
                        --weaken_factor $2

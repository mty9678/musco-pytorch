#!/bin/bash

echo "Ahoj"
ModelList=('vgg16' 'resnet50')
for conv_split in 1 3 6 13
do
  for model in "${ModelList[@]}"
    do   
	  echo "============================================"
	  echo "Compress $model with split factor $conv_split"
      if [ "$conv_split" -eq 1 ] && [ "$model" = "resnet50" ]; then
          python evaluate_demo.py --model $model --dataset imagenet \
                                  --data_dir /workspace/raid/data/datasets \
                                  --train_iters 1000 \
                                  --val_iters 100 \
                                  --save_dir /workspace/raid/data/lmarkeeva/conv_tests \
                                  --conv_split $conv_split \
                                  --validate_before_ft \
                                  --gpu_number $2 \
								  --weaken_factor $1
      else
        if [ "$model" = "resnet50" ]; then
        python evaluate_demo.py --model $model --dataset imagenet \
                                --data_dir /workspace/raid/data/datasets \
                                --train_iters 1000 \
                                --val_iters 100 \
                                --save_dir /workspace/raid/data/lmarkeeva/conv_tests \
                                --conv_split $conv_split \
                                --validate_before_ft \
                                --gpu_number $2 \
								--weaken_factor $1
		else
            python evaluate_demo.py --model $model \
                        --model_weights $3 \
                        --dataset imagenet \
                        --data_dir /workspace/raid/data/datasets \
                        --train_iters 1000 \
                        --val_iters 100 \
                        --save_dir /workspace/raid/data/lmarkeeva/conv_tests \
                        --conv_split $conv_split \
                        --validate_before_ft \
                        --gpu_number $2 \
                        --weaken_factor $1
		fi
      fi

    done
done

python evaluate_demo.py --model resnet50 --dataset imagenet \
                        --data_dir /workspace/raid/data/datasets \
                        --train_iters 1000 \
                        --val_iters 100 \
                        --save_dir /workspace/raid/data/lmarkeeva/conv_tests_resnet_conv_split \
                        --conv_split 1 \
                        --resnet_split \
                        --validate_before_ft \
                        --gpu_number $2 \
						--weaken_factor $1
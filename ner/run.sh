#!/bin/sh

model_save_dir=/scratch/maths/dual/mt6170499/ner/model
preds_save_dir=/scratch/maths/dual/mt6170499/ner/preds
cache_dir=/scratch/maths/dual/mt6170499/.cache

for model_name in matscibert scibert; do
    for arch in bert bert-crf bert-bilstm-crf; do
        for dataset in sofc sofc_slot; do
            for fold in {1..5}; do
                echo $model_name $arch $dataset $fold
                python -u ner.py --model_name $model_name --model_save_dir $model_save_dir --preds_save_dir $preds_save_dir --cache_dir $cache_dir --architecture $arch --dataset_name $dataset --fold_num $fold
            done
        done

        echo $model_name $arch matscholar
        python -u ner.py --model_name $model_name --model_save_dir $model_save_dir --preds_save_dir $preds_save_dir --cache_dir $cache_dir --architecture $arch --dataset_name matscholar
        
    done
done

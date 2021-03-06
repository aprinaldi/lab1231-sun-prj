#!/bin/sh
if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

root_dir=/home/tor/xprmnt/knowledge-construction/relative-location
timestamp="$(date +'%Y%m%d.%H%M%S')"

#
chosen_cprime=$1
dirichlet_noise=False
img_list_filepath=/home/tor/dataset/pascal/VOC2010/meta/split_voc2010_philipp/Train.txt
gt_csv_dir=/home/tor/dataset/pascal/VOC2010/VOCdevkit/VOC2010/SegmentationClass-csv
img_dir=/home/tor/dataset/pascal/VOC2010/VOCdevkit/VOC2010/JPEGImages

prob_map_out_id=prob-map-dirichlet-off #prob-map.$timestamp
prob_map_out_dir=$root_dir/$prob_map_out_id

#
export PYTHONPATH=$PYTHONPATH:/home/tor/lab1231-sun-prj/util/src-py
exe=/home/tor/lab1231-sun-prj/knowledge-constructor/relative_location_knowledge.py
python  $exe \
		$chosen_cprime $dirichlet_noise \
		$img_list_filepath $gt_csv_dir $img_dir \
		$prob_map_out_dir

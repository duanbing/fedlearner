#!/bin/bash
export CUDA_VISIBLE_DEVICES=""

python make_data.py

export CERT_BASE_DIR=/Users/bytedance/Project/double_tls/pa
python leader.py --local-addr=localhost:50051     \
                 --peer-addr=pb.com:50052      \
                 --data-path=data/leader          \
		 --checkpoint-path=log/checkpoint \
		 --save-checkpoint-steps=10 \
		 --epoch_num=10 &

export CERT_BASE_DIR=/Users/bytedance/Project/double_tls/pb
python follower.py --local-addr=localhost:50052     \
                   --peer-addr=pa.com:50051      \
                   --data-path=data/follower/       \
		   --checkpoint-path=log/checkpoint \
		   --save-checkpoint-steps=10 \
		   --epoch_num=10

wait

rm -rf data log
echo "test done"

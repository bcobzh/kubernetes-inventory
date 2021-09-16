#!/bin/bash
set -x

cd /tmp
python3 /lbn/inventory.py
python3 /lbn/push_on_s3.py

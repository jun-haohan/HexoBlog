#!/bin/bash

SERVER=root@47.99.133.212

echo "=== build main ==="
hexo clean
hexo g --config _config.yml

echo "=== deploy main ==="
rsync -avz --delete public/ $SERVER:/www/hexo/

echo "=== build uw ==="
hexo clean
hexo g --config _config.uw.yml

echo "=== deploy uw ==="
rsync -avz --delete public_uw/ $SERVER:/www/hexo_uw/

echo "done"
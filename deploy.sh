#!/bin/bash

SERVER=root@jun-haohan.com

echo "== build main =="
hexo clean
hexo g --config _config.yml

echo "== deploy main =="
rsync -avz --delete public/ $SERVER:/www/hexo/

echo "== build uw =="
hexo clean
hexo g --config _config.uw.yml

echo "== deploy uw =="
rsync -avz --delete public_uw/ $SERVER:/www/hexo_uw/

echo "done"
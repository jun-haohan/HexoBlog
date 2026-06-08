#!/bin/bash

# ./deploy.sh运行，wsl内需要指明路径

SERVER=root@jun-haohan.com

echo "== trans Excel main =="
python excel_to_html.py source_main/

echo "== build main =="
hexo clean
hexo g --config _config.yml

echo "== deploy main =="
rsync -avz --delete public/ $SERVER:/www/hexo/


echo "== trans Excel uw =="
python excel_to_html.py source_uw/

echo "== build uw =="
hexo clean
hexo g --config _config.uw.yml

echo "== deploy uw =="
rsync -avz --delete public_uw/ $SERVER:/www/hexo_uw/

echo "done"
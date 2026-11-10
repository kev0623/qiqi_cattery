#!/usr/bin/env bash
# 把 Artifact 格式的頁面（無 doctype / head）包成可獨立開啟的完整 HTML，供 GitHub Pages 使用。
# 用法：bash scripts/build-pages.sh
# 注意：img/ 與 data/site.json 放在根目錄，是後台 admin.html 直接寫入的位置，這個腳本不會動它們。
set -euo pipefail
cd "$(dirname "$0")/.."

wrap() { # $1 來源  $2 輸出
  {
    printf '<!doctype html>\n<html lang="zh-Hant">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
    printf '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
    printf '</head>\n<body>\n'
    cat "$1"
    printf '\n</body>\n</html>\n'
  } > "$2"
  echo "built $2"
}

wrap prototype/index.html index.html
wrap prototype/admin.html admin.html
wrap docs/design-spec.html design.html
touch .nojekyll

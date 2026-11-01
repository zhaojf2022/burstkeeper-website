#!/usr/bin/env bash
# 静态自检：data-zh / data-en 属性里不允许出现 HTML（会被 textContent 渲染成源码）
set -u
fail=0
for f in index.html company.html privacy.html; do
  if grep -qE 'data-(zh|en)="[^"]*<[a-zA-Z/]' "$f"; then
    echo "FAIL $f: data-* 属性里含 HTML 标签"
    grep -nE 'data-(zh|en)="[^"]*<[a-zA-Z/]' "$f" | head -3
    fail=1
  fi
  # 只拦“转义后的标签”（&quot; 紧跟 <a / <a href 之类），普通引号文本不算
  if grep -qE 'data-(zh|en)="[^"]*&quot;[^"]*(mailto:|tel:|href)' "$f"; then
    echo "FAIL $f: data-* 属性里含转义后的标签"
    grep -nE 'data-(zh|en)="[^"]*&quot;[^"]*(mailto:|tel:|href)' "$f" | head -2
    fail=1
  fi
  if grep -qE 'PLACEHOLDER|待補|TODO' "$f"; then
    echo "FAIL $f: 仍有占位符或内部提示"
    fail=1
  fi
done
[ "$fail" = 0 ] && echo "PASS: 三个页面无属性内 HTML、无占位符"
exit "$fail"

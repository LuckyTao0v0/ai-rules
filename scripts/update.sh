#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
sources_file="$root_dir/sources.txt"
custom_file="$root_dir/Loon/custom.list"
output_file="$root_dir/Loon/AI.list"
tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

mkdir -p "$(dirname "$output_file")"

while IFS= read -r entry || [[ -n "$entry" ]]; do
  entry="${entry%$'\r'}"
  [[ -z "$entry" || "$entry" == \#* ]] && continue

  name="${entry%%|*}"
  source="${entry#*|}"

  if [[ -z "$name" || "$name" == "$source" ]]; then
    echo "sources.txt 格式错误：$entry" >&2
    exit 1
  fi

  echo "# > $name" >> "$tmp_file"

  curl --fail --location --silent --show-error --retry 3 "$source" |
    sed -e 's/\r$//' -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' >> "$tmp_file"
done < "$sources_file"

if [[ -f "$custom_file" ]]; then
  sed -e 's/\r$//' -e '/^[[:space:]]*$/d' "$custom_file" >> "$tmp_file"
fi

{
  echo '# NAME: AI'
  echo '# DESCRIPTION: AI rules for Loon'
  echo '# SOURCE: https://github.com/blackmatrix7/ios_rule_script'
  echo '# GENERATED: Do not edit manually; update sources.txt or Loon/custom.list instead.'
  echo
  awk '!seen[$0]++' "$tmp_file"
} > "$output_file"

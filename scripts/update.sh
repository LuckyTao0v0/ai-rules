#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
sources_file="$root_dir/sources.txt"
output_file="$root_dir/Loon/AI.list"
tmp_file="$(mktemp)"
trap 'rm -f "$tmp_file"' EXIT

mkdir -p "$(dirname "$output_file")"

while IFS= read -r source || [[ -n "$source" ]]; do
  source="${source%$'\r'}"
  [[ -z "$source" || "$source" == \#* ]] && continue
  curl --fail --location --silent --show-error --retry 3 "$source" |
    sed -e 's/\r$//' -e '/^[[:space:]]*#/d' -e '/^[[:space:]]*$/d' >> "$tmp_file"
done < "$sources_file"

{
  echo '# NAME: AI'
  echo '# DESCRIPTION: OpenAI, Claude and Gemini rules for Loon'
  echo '# SOURCE: https://github.com/blackmatrix7/ios_rule_script'
  echo '# GENERATED: Do not edit manually; update sources.txt instead.'
  echo
  awk '!seen[$0]++' "$tmp_file"
} > "$output_file"

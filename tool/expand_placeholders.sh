#!/bin/bash

function expand_placeholders_from_file() {
    declare -n ref="$1"
    local target_file=$(mktemp)
    cp "$2" "$target_file"

    for ((i=0; i<${#ref[@]}; i+=2)); do
        local placeholder="${ref[i]}"
        local insert_file=$(mktemp)
        sed '$a\\' "${ref[i+1]}" > "$insert_file"  # 末尾に改行がない場合は挿入

        sed -i "/${placeholder}/ {
            r ${insert_file}
            d
        }" "$target_file"

        rm -f "$insert_file"
    done

    cat "$target_file"
    rm -f "$target_file"
}

function expand_placeholders_from_text() {
    declare -n ref="$1"
    local target_file=$(mktemp)
    cp "$2" "$target_file"

    for ((i=0; i<${#ref[@]}; i+=2)); do
        local placeholder="${ref[i]}"
        # 置き換える文字列の &, /, \ を \&, \/, \\ に変換する
        local replacement=$(printf '%s\n' "${ref[i+1]}" | sed 's|[&/\]|\\&|g')
        sed -i "s/${placeholder}/${replacement}/g" "$target_file"
    done

    cat "$target_file"
    rm -f "$target_file"
}

declare -a placeholders1=(
  "@SHADER0@" gradient.hlsl
  "@SHADER1@" color.hlsl
  "@SHADER2@" gradient_plus.hlsl
)

version=$(git describe --tags --abbrev=0)  # Gitタグからバージョンを取得
declare -a placeholders2=(
  "@INFO@" "グラデーション+"
  "@VERSION@" "$version"
  "@AUTHOR@" "Azurite"
)

input_file_name="グラデーション+.in.anm2"
output_file_name="グラデーション+.anm2"
expand_placeholders_from_text placeholders2 <(expand_placeholders_from_file placeholders1 "$input_file_name") > "$output_file_name"

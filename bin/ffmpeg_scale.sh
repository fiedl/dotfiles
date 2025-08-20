# https://chatgpt.com/c/685c7c91-1648-8007-9c00-401d3c9fef10

input="$1"
output="${input%.*}_scaled.mov"
ffmpeg -i "$input" -vf "scale=iw*0.5:ih*0.5,pad=ceil(iw/2)*2:ceil(ih/2)*2" "$output"

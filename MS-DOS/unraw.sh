#!/bin/sh
#alias sox='/opt/local/bin/sox'

while [ $# -gt 0 ]; do
    [ ! -f "$1" ] && { echo "Invalid path: $1" >&2; continue; }
    clean_path=$(printf '%s' "$1" | sed 's/.[^.]*$//')

    for bits in 8 16 24 32; do
        bits_mod=$(($bits / 8))
        for channels in 1 2; do
            channels_mod=$((($channels)))
            sample_rate=$(((44100 / $bits_mod) / $channels_mod))

            encodings='unsigned signed'
            [ $bits = 8 ] && encodings="$encodings a-law u-law"

            for encoding in $encodings; do
                out="${clean_path}_${bits}-bit_${encoding}_${channels}-channels"
                options="--rate $sample_rate --encoding $encoding --bits $bits --channels $channels"
                if [ $bits -gt 8 ]; then
                    for endianness in little big; do
			sox $options --endian $endianness $1 ${out}_$endianness-endian.wav
                    done
                else
                    case "$encoding" in
                        ?-law)
                            for ordering in '' '-X'; do
                                [ -n "$ordering" ] && suffix='-reverse' || suffix=
                                sox $options $ordering $1 $out$suffix.wav
                            done
                        ;;
                        *)
                            sox $options $1 $out.wav
                        ;;
                    esac
                fi
            done
        done
    done
    shift
done

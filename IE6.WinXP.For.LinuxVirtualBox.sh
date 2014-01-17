#!/bin/bash

name=IE6.WinXP.For.LinuxVirtualBox
parts=(sfx)

base_md5=https://az412801.vo.msecnd.net/vhd/md5/122013
base_build=https://az412801.vo.msecnd.net/vhd/VMBuild_20131127/VirtualBox/IE6_WinXP/Linux

for part in "${parts[@]}"; do
  wget -nc $base_build/$name.$part
  wget -nc $base_md5/$name.$part.txt
  diff <(md5sum $name.$part | cut -c1-32) <(cat $name.$part.txt | cut -c1-32) || echo "diff failed for $name.$part" && exit 1
done

./$name.sfx

for part in "${parts[@]}"; do
  rm $name.$part
  rm $name.$part.txt
done

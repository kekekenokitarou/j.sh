#!/usr/bin/env bash

if [[ $# -ne 2 ]] ; then
    echo "使い方 : $0 形式 クラス名(形式がmainの場合は、課題番号)"
    exit 1
fi

declare SCRIPT
declare CLASS
TYPE=$1


if [[ $TYPE == "main" ]] ; then
    CLASS=Kadai$2
    SCRIPT="public class $CLASS{
    public static void main(String[] args){
    }
}"
elif [[ $TYPE == "class" ]] ; then
    CLASS=$2
    SCRIPT="public class $CLASS{
}"
elif [[ $TYPE == "con" ]] ; then
    CLASS=$2
    SCRIPT="public class $CLASS{
    public $CLASS(){
    }
}"
else
    echo "使い方 : 形式はmain,class,conです。"
    exit 1
fi

echo "${SCRIPT}" > "${CLASS}.java"

echo "[$(date '+%y-%m-%d %H:%M:%S')] ${CLASS}.java"を出力しました。

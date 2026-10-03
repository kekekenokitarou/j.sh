#!/usr/bin/env bash

if [[ $# -ne 2 ]] ; then
    echo "使い方 : $0 形式 クラス名(形式がmainの場合は、課題番号。runの場合は、ファイル名(〜.java))"
    exit 1
fi

declare SCRIPT
declare CLASS
TYPE=$1


if [[ $TYPE == "run" ]] ; then
    if [[ $2 != *.java || $2 == */* || ! -f $2 ]] ; then
        echo "エラー : カレントディレクトリに $2 が見つかりません。ファイル名(〜.java)で指定してください。" >&2
        exit 1
    fi
    CLASS=${2%.java}
    if ! javac "${CLASS}.java" ; then
        echo "エラー : ${CLASS}.java のコンパイルに失敗しました。" >&2
        exit 1
    fi
    exec java "${CLASS}"
fi

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
    echo "使い方 : 形式はmain,class,con,runです。"
    exit 1
fi

if [[ -e "${CLASS}.java" ]] ; then
    echo "エラー : ${CLASS}.java はすでに存在します。上書きしません。" >&2
    exit 1
fi

echo "${SCRIPT}" > "${CLASS}.java"

echo "${CLASS}.javaを出力しました。"

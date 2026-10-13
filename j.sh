#!/usr/bin/env bash

if [[ $# -lt 2 ]] ; then
    echo "使い方 : $0 形式 クラス名 [Javaへの引数...]"
    exit 1
fi

declare SCRIPT
declare CLASS
TYPE=$1
TARGET=$2

if [[ $TYPE == "run" ]] ; then
    if [[ $TARGET != *.java || $TARGET == */* || ! -f $TARGET ]] ; then
        echo "エラー : カレントディレクトリに $TARGET が見つかりません。ファイル名(〜.java)で指定してください。" >&2
        exit 1
    fi
    CLASS=${TARGET%.java}
    OUT_DIR=.jbuild
    if ! javac -d "${OUT_DIR}" -sourcepath . "${CLASS}.java" ; then
        echo "エラー : ${CLASS}.java のコンパイルに失敗しました。" >&2
        exit 1
    fi
    
    shift 2
    
    exec java -cp "${OUT_DIR}" "${CLASS}" "$@"
fi

if [[ $TYPE == "main" ]] ; then
    CLASS=Kadai$TARGET
    SCRIPT="public class $CLASS{
    public static void main(String[] args){
    }
}"
elif [[ $TYPE == "class" ]] ; then
    CLASS=$TARGET
    SCRIPT="public class $CLASS{
}"
elif [[ $TYPE == "con" ]] ; then
    CLASS=$TARGET
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

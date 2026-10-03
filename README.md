# j.sh

Java のクラスファイルのひな形を作るシェルスクリプトです。

## インストール

```sh
git clone https://github.com/kekekenokitarou/j.sh.git
cd j.sh
mkdir -p ~/.local/bin
ln -s "$PWD/j.sh" ~/.local/bin/j.sh
```

`~/.local/bin` に PATH が通っていない場合は、`~/.zshrc` に次の行を追加してください。

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## 使い方

```sh
j.sh 形式 名前
```

形式は `main`、`class`、`con`、`run` の4つです。

| 形式 | 名前に渡すもの | 作られるファイル | 中身 |
|---|---|---|---|
| `main` | 課題番号 | `Kadai<番号>.java` | `main` メソッド付きのクラス |
| `class` | クラス名 | `<クラス名>.java` | 空のクラス |
| `con` | クラス名 | `<クラス名>.java` | コンストラクタ付きのクラス |

ファイルはコマンドを実行したディレクトリに作られます。

`run` はファイルを作らず、カレントディレクトリにある Java ファイルをコンパイルしてそのまま実行します。名前にはカレントディレクトリにあるファイル名を `Kadai3.java` のように `.java` まで含めて渡します。

## 例

```console
$ j.sh main 3
Kadai3.javaを出力しました。
```

```java
public class Kadai3{
    public static void main(String[] args){
    }
}
```

```console
$ j.sh con Student
Student.javaを出力しました。
```

```java
public class Student{
    public Student(){
    }
}
```

## コンパイルして実行する

```console
$ j.sh run Kadai3.java
Hello
```

コンパイルに失敗した場合は、`javac` のエラーのあとにメッセージを表示して終了します(実行はしません)。

```console
$ j.sh run Kadai3.java
Kadai3.java:3: エラー: ';'がありません
...
エラー : Kadai3.java のコンパイルに失敗しました。
```

## 同じ名前のファイルがあるとき

同じ名前のファイルがすでにある場合は、上書きせずにエラーで終了します。

```console
$ j.sh main 3
エラー : Kadai3.java はすでに存在します。上書きしません。
```

作り直したいときは、先にそのファイルを削除してから実行してください。

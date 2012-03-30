# xl-pik - xyzzy から Pik で Ruby を切り替えるツール

* Home URL: <http://miyamuko.s56.xrea.com/xyzzy/xl-pik/intro.htm>
* Version: 0.0.1


## SYNOPSIS

```
M-x pik-switch
M-x pik-switch-dialog
M-x pik-switch-popup
```


## DESCRIPTION

xl-pik は [Pik] を使って xyzzy から利用する Ruby を切り替えるためのツールです。

Pik を使えば Windows 環境に複数バージョンの Ruby をインストールして、
切り替えて利用することができます。

xl-pik を使うことで Pik によって切り替えた環境変数を xyzzy に反映することができます。
xl-pik で Ruby を切り替えた後は `C-x &` や `C-x |` や `C-x c` など外部コマンドを
実行する処理全てに反映されます。

**注意: xl-pik は xyzzy 0.2.2.235 では利用できません。**
以下のどちらかのバージョンを利用してください。

  * [xyzzy 0.2.2.236 以降]
  * [xyzzy 0.2.3.3 以降]


## INSTALL

1. [NetInstaller] で xl-pik, ansify をインストールします。

2. ni-autoload を利用していない場合は、
   ~/.xyzzy または site-lisp/siteinit.l に以下のコードを追加します。

    ```lisp
    (require "xl-pik")
    ```

    ※ ni-autoload を利用している場合は設定は不要です。

3. 設定を反映させるため xyzzy を再起動してください。

    ※siteinit.l に記述した場合には再ダンプが必要です。


## TODO

  * pik list の結果をバッファに表示して選択して切り替え


## KNOWN BUGS

なし。

要望やバグは [GitHub Issues] か [@miyamuko] まで。


## AUTHOR

みやむこ かつゆき (<mailto:miyamuko@gmail.com>)


## COPYRIGHT

xl-pik は MIT/X ライセンスに従って本ソフトウェアを使用、再頒布することができます。

    Copyright (c) 2012 MIYAMUKO Katsuyuki.

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


  [xyzzy 0.2.2.236 以降]: http://xyzzy-022.github.com
  [xyzzy 0.2.3.3 以降]: https://bitbucket.org/mumurik/xyzzy/wiki/Home
  [Pik]: https://github.com/vertiginous/pik
  [NetInstaller]: http://www7a.biglobe.ne.jp/~hat/xyzzy/ni.html
  [GitHub Issues]: http://github.com/miyamuko/xl-pik/issues
  [@miyamuko]: http://twitter.com/home?status=%40miyamuko%20%23xyzzy%20xl-pik%3a%20

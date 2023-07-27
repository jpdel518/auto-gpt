# 日本語化AutoGPT

## 概要
AutoGPTは日本語の入力を行えるが、英語の回答が返ってくるため英語に精通していないと使いづらい問題がある。  
このプロジェクトではAutoGPTからの回答を日本語に翻訳することで、日本語での入力・出力を可能にする。
AutoGPTは下記リポジトリのstable v0.4.5を使用。
https://github.com/Significant-Gravitas/Auto-GPT

## 使う前の注意点
M1 Macで動くようにDocker環境を作成しているので、それ以外の環境で動かす場合には
Dockerfileの中に記述ある`From`から`--platform=linux/amd64`を削除して動かしてください。

## 使い方
1. OpenAI APIの設定  
Auto-GPT/.env.templateをコピーしてAuto-GPT/.envを作成する。  
.envの`OPENAI_API_KEY=`に自身が登録しているOpenAI APIで作成したAPIキーを記載する。  
参考：https://platform.openai.com/account/api-keys

1. DeepL APIの設定  
.env.templateをコピーして.envを作成する。  
.envの`DEEPL_API_KEY=`に自身が登録しているDeepL APIで作成したAPIキーを記載する。  
参考：https://www.deepl.com/ja/account/summary

1. Docker起動  
Auto-GPTではファイルでの出力も行われるため、ファイルの同期を行う必要があった。  
そのため、docker-composeを用いてvolumeをマウントすることで同期を行えるように対応している。  
   ```shell
   docker-compose up -d --build
   ```

1. Docker実行
   ```shell
   docker-compose exec -it auto-gpt bash
   ```

1. AutoGPT実行
   ```shell
   conda activate auto-gpt
   cd Auto-GPT
   python -m autogpt
   ```

## 簡易的なAutoGPTの使い方
1. AIアシスタントの作成  
`I want Auto-GPT to:`という文章に続けて、`--manual`と入力
2. AIアシスタントの名前
`AI Name:`という文章に続けて、`test`と入力
3. AIの役割
どんな役割を持つAIかを入力する。
4. AIの目標
`Goal 1:` `Goal2:`と言う文章に続けて、AutoGPTを通じて達成したい目標する

目標まで入力すると、目標を達成するための考え方やその理由、プランなどを出力する。  
出力後、次のアクションが提案される。  
次のアクションに従う場合は`Input:`と言う文章に続けて、`y`と入力する。  
次のアクションを行わず、自由入力によりAutoGPTにアクションを提示したい場合は`Input:`と言う文章に続けて、`. 自由入力する文章`と入力する。  
例えば、これまでにAutoGPTから提示された要約が欲しい場合は下記のように入力する。
```text
. ここまでの要約をテキストファイルに出力してください。
```
↑を実行するとAuto-GPT/autogpt/workspace/auto_gpt_workspaceに要約が出力される。

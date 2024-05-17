# 設計
## 業務フロー
### プロジェクト作成フェーズ

```mermaid
sequenceDiagram
    participant 講師
    participant システム
    participant データベース
    participant ローカルPC
    participant 生徒A
    participant 生徒B

    講師->>システム: プロジェクトを作成
    システム->>データベース: プロジェクト情報を保存
    講師->>システム: プロジェクトに生徒Aをメンバーとして登録
    システム->>データベース: 生徒Aの情報を保存
    講師->>システム: プロジェクトに生徒Bをメンバーとして登録
    システム->>データベース: 生徒Bの情報を保存
    システム->>生徒A: 招待メールを送信
    システム->>生徒B: 招待メールを送信
    alt プロジェクトメンバーに生徒が存在しない場合
        講師->>生徒A: URLを共有してクラスに生徒を招待
        生徒A->>システム: 講師から共有されたURLにアクセスする
        講師->>生徒B: URLを共有してクラスに生徒を招待
        生徒B->>システム: 講師から共有されたURLにアクセスする
    end
    講師->>システム: 締切時間を設定する
    システム->>データベース: 締切時間を保存
    講師->>システム: お手本になるコードや課題を共有する
    システム->>ローカルPC: お手本になるコードや課題を保存
```

### コーディング、質問と回答のプロセス

```mermaid
sequenceDiagram
    participant 講師
    participant システム
    participant データベース
    participant ローカルPC
    participant 生徒A
    participant 生徒B

    講師->>生徒A: 生徒指導
    講師->>生徒B: 生徒指導
    生徒A->>システム: お手本になるコードや課題を確認しながらシステムを使ってコーディングする
    alt 質問が発生した場合
        loop 質問と回答のプロセス
            生徒B->>システム: 質問を投稿する
            システム->>データベース: 質問を保存
            システム->>講師: 質問の通知を送る
            alt 講師が追加情報を必要とする場合
                講師->>システム: 追加情報のリクエストを投稿する
                システム->>データベース: 追加情報のリクエストを保存
                システム->>生徒B: 追加情報のリクエストを通知する
                生徒B->>システム: 追加情報を提供する
                システム->>データベース: 追加情報を保存
                システム->>講師: 追加情報を通知する
            else 講師が質問に回答する場合
                講師->>システム: 回答を投稿する
                システム->>データベース: 回答を保存
                システム->>生徒B: 回答を通知する
            end
        end
    else
        生徒B->>システム: お手本になるコードや課題を確認しながらシステムを使ってコーディングする
    end
    note over 生徒A,生徒B: エラー処理
```

### エラー処理

```mermaid
sequenceDiagram
    participant 講師
    participant システム
    participant データベース
    participant ローカルPC
    participant 生徒A
    participant 生徒B

    alt コーディング中にコードエラーが発生した場合
        生徒A->>システム: コーディング中にコードエラーが発生する
        システム->>生徒A: コードエラーメッセージを表示する
        生徒A->>システム: エラーメッセージを確認して修正する
    end
    alt コーディング中にシステムエラーが発生した場合
        生徒A->>システム: コーディング中にシステムエラーが発生する
        システム->>生徒A: システムエラーメッセージを表示する
        生徒A->>システム: システムエラーメッセージを確認し、必要に応じて講師またはシステム管理者に連絡する
    end
    alt コーディング中にエラーが発生した場合
        生徒B->>システム: コーディング中にエラーが発生する
        システム->>生徒B: エラーメッセージを表示する
        生徒B->>システム: エラーメッセージを確認して修正する
    end
    alt コーディング中にエラーが発生した場合
    生徒B->>システム: コーディング中にエラーが発生する
    システム->>生徒B: エラーメッセージを表示する
    note over 生徒B: エラーメッセージを確認して修正する
    end
```

### プロジェクトCLOSEDフェーズ

```mermaid
sequenceDiagram
    participant 講師
    participant システム
    participant データベース
    participant ローカルPC
    participant 生徒A
    participant 生徒B

    講師->>システム: 生徒の進捗を確認する
    alt すべての生徒が課題を完了した場合
        note over 生徒A,生徒B: 課題を完了する
        システム->>講師: 全生徒の課題完了を通知する
        note over 講師: プロジェクトを手動でクローズする
    else 締切時間が来た場合
        システム->>講師: 締切時間の通知を送る
        note over 講師: プロジェクトを手動でクローズするまはた締切を延長する
    end
```

## 画面遷移図

<iframe style="border: 1px solid rgba(0, 0, 0, 0.1);" width="800" height="450" src="https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fdesign%2FYHIhf7m3YkQLXCtAyU2VyG%2FIruka-Code-%25E7%2594%25BB%25E9%259D%25A2%25E9%2581%25B7%25E7%25A7%25BB%25E5%259B%25B3%3Fnode-id%3D0%253A1%26t%3De7h0zm3U5zh9Ogh8-1" allowfullscreen></iframe>

### URL
[https://www.figma.com/design/YHIhf7m3YkQLXCtAyU2VyG/Iruka-Code-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=e7h0zm3U5zh9Ogh8-0](https://www.figma.com/design/YHIhf7m3YkQLXCtAyU2VyG/Iruka-Code-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=e7h0zm3U5zh9Ogh8-0)

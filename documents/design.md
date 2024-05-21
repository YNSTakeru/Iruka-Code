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
![screen-transition-diagram](./img/screen-transition-diagram.png)

### URL
[https://www.figma.com/design/YHIhf7m3YkQLXCtAyU2VyG/Iruka-Code-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=e7h0zm3U5zh9Ogh8-0](https://www.figma.com/design/YHIhf7m3YkQLXCtAyU2VyG/Iruka-Code-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=e7h0zm3U5zh9Ogh8-0)



## ワイアーフレーム

### URL
[https://www.figma.com/design/cItZoSDVeRNs1e1wRm2cvI/%E3%83%AF%E3%82%A4%E3%83%A4%E3%83%BC%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0?node-id=0-1&t=J9i4kgLDVBqhkVf1-0](https://www.figma.com/design/cItZoSDVeRNs1e1wRm2cvI/%E3%83%AF%E3%82%A4%E3%83%A4%E3%83%BC%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0?node-id=0-1&t=J9i4kgLDVBqhkVf1-0)


## ER図

```mermaid
erDiagram
    Users ||--o{ Teams : leader_id
    Users ||--o{ Leader_Access_Datetime : leader_id
    Users ||--o{ Class_memos : leader_id
    Users ||--o{ Members : user_id
    Users ||--o{ Comments : user_id
    Users ||--o{ Comment_Targets : target_id
    Users ||--o{ Answers : user_id
    Teams ||--o{ Projects : team_id
    Projects ||--o{ Leader_Access_Datetime : project_id
    Projects ||--o{ Classes : project_id
    Projects ||--o{ Comment_Tags : project_id
    Classes ||--o{ Class_memos : class_id
    Classes ||--o{ Members : class_id
    Classes ||--o{ Comments : class_id
    Members ||--o{ Member_Memos : member_id
    Class_memos ||--o{ Member_Memos : memo_id
    Comments ||--o{ Comment_Targets : comment_id
    Comments ||--o{ Comment_Tag_Pivot : comment_id
    Comments ||--o{ Comment_Files : comment_id
    Comments ||--o{ Comment_Positions : comment_id
    Comments ||--o{ Answers : comment_id
    Comment_Tags ||--o{ Comment_Tag_Pivot : tag_id
```

## テーブル定義書

### Usersテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| username | VARCHAR(50) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| email | VARCHAR(255) | NULL | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | No |
|image_url| VARCHAR(255) | NULL | No | No | No |
| password | VARCHAR(128) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
delete_flag | BOOLEAN | FALSE | No | No | No |


## Teamsテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| team_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| leader_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| team_name | VARCHAR(255) | NULL | Yes | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

### Projectsテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| project_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| team_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| project_name | VARCHAR(255) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| start_timestamp | DATETIME | CURRENT_TIMESTAMP | No | No | No |
| end_timestamp | DATETIME | NULL | No | No | No |
| is_open | BOOLEAN | TRUE | No | No | No |
| description | TEXT | NULL | No | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| max_participant_count | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| max_class_num | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

### Leader_Access_Datetimeテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| leader_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| project_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| access_date | DATETIME | CURRENT_TIMESTAMP | No | No | No |

### Classesテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| class_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| project_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| class_name | VARCHAR(255) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| start_timestamp | DATETIME | CURRENT_TIMESTAMP | No | No | No |
| end_timestamp | DATETIME | NULL | No | No | No |
| is_open | BOOLEAN | TRUE | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |
| max_participant_count | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |

### Class_memosテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| memo_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| class_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| leader_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| memo_title | VARCHAR(255) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| memo_content | TEXT | NULL | No | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

### Membersテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| member_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| user_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| class_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| access_date | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |

### Member_Memosテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| member_memo_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| member_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| memo_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| memo_content | TEXT | NULL | No | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

### Commentsテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| comment_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| class_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| user_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| comment_title | VARCHAR(255) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| comment_content | TEXT | NULL | No | No | No |
| is_solved | BOOLEAN | FALSE | No | No | No |
| is_answer | BOOLEAN | FALSE | No | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

### Comment_Targetsテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| comment_id | INT | NULL | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| target_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |

### Comment_Tagsテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| tag_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| tag_name | VARCHAR(50) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| project_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |

### Comment_Tag_Pivotテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| comment_id | INT | NULL | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| tag_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |

### Comment_Filesテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| file_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| comment_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| file_name | VARCHAR(50) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

### Comment_Positionsテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| position_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| comment_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| start_text_position | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| end_text_position | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| coding_area_position | VARCHAR(255) | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

### Answersテーブル
| 項目名 | データ型 | 初期値 | 必須 | インデックス | 主キー |
| --- | --- | --- | --- | --- | --- |
| answer_id | INT | AUTO_INCREMENT | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> | <span style="color:#0000FF">Yes</span> |
| comment_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| user_id | INT | NULL | <span style="color:#0000FF">Yes</span> | No | No |
| answer_content | TEXT | NULL | No | No | No |
| created_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| updated_at | TIMESTAMP | CURRENT_TIMESTAMP | No | No | No |
| deleted_flag | BOOLEAN | FALSE | No | No | No |

## システム構成図 (アプリケーション版)

```mermaid
graph LR
    A[User\nブラウザ] -- HTTP/HTTPS --> B[Nextjs 13.5\nFrontend]
    B -- API\nJson --> C[Laravel 10\nBackend]
    C -- HTTP --> D[Nginx]
    D -- SQL --> E[(MySQL 8.0 \nDatabase)]
    G[Netlify\nDeployment for Frontend]
    B --Deploy --> G
```


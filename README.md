# FaceAPI

## 簡介

提供一個可以方便儲存臉部資料的服務。

## 安裝

### 1. xampp 

此 API 使用 xampp 提供的 Apache 網頁伺服器及 MariaDB 資料庫系統。
從以下連結下載並安裝。

https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/7.4.16/

啟動 xampp，打開 Apache 和 MySQL。

### 2. 匯入資料庫

從網頁進入 `localhost/phpmyadmin`，在左側導覽列建立一個資料庫取名為 `FaceDB`。建立完成後按上方匯入，選擇 `faceapi.sql` 檔案。

### 3. Git clone

將 Github 上的檔案 clone 到你安裝 xampp 的位置內的 `htdocs` 資料夾。

### $. 修改設定檔

修改 `_config.php` 中的設定檔(如果你有改帳密的話)。

### 4. 確認安裝完成

從網頁進入 `localhost/FaceAPI/create.php`，若出現

`{"success":false,"message":"Lost parameters"}`

則代表安裝成功。
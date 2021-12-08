# FaceAPI

## 簡介

影片人物檢索系統，此系統提供一個網頁介面，可以用來檢視監視錄影檔案、搜尋某個人在監視器中出現的時間點，並可以觀看那些片段。

> https://1drv.ms/u/s!AgPlzKHSGjT8h_U4_n1njJlo6CnuSQ?e=9TejUV
>
> 範例影片和 weight 檔

## 安裝 Web

### 1. XAMPP

此系統在 Windows 10 作業系統下執行，建議使用 XAMPP 提供的 Apache 網頁伺服器及 MariaDB 資料庫系統。
從以下連結下載並安裝。

https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/7.4.16/

啟動 XAMPP，打開 Apache 和 MySQL。

### 2. 匯入資料庫

使用瀏覽器進入 `localhost/phpmyadmin`，在左側導覽列建立一個資料庫取名為 `FaceDB`。建立完成後按上方匯入，選擇 `facedb.sql` 檔案。

### 3. Git Clone

將 GitHub 上的檔案 clone 或解壓縮到你的伺服器網站根目錄內 (建議 `C:\xampp\htdocs\FaceAPI` )。

### 4. 修改設定檔

修改 `_config.php` 中的設定檔(如果你有改帳密的話)。

### 5. 確認安裝完成

使用瀏覽器進入 `localhost/FaceAPI`，若可以看到網頁及檢索範例影片代表安裝成功

## 安裝 Python 必要項目

### 1. Python

* Python 3.8
* PIP
* Conda (Anaconda)

* `environment.yml` 內的所有 dependencies (包括 Conda 及 PIP 的所有套件)

> **dlib 可能會需要先另外安裝**

### 2. Weight

將 weight 檔案放在 `yolov5/weights` 資料夾底下

### 3. 執行

#### 讀影片 

```shell
python track2.py --source walk.mp4  --yolo_weights yolov5/weights/crowdhuman_yolov5m.pt --classes 0
```

需要有 walk.mp4 在同個資料夾

#### 讀圖片 

```shell
python input.py --image anthony.PNG 
```

需要有 anthony.png 的人像照片在同資料夾

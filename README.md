![R (2)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/a064577c-9302-4f43-b3bf-3d4f84245a6f)
نام پروژه :  داشبورد وایرگارد با ربات (فارسی و انگلیسی)
---------------------------------------------------------------
----------------------------------

**توضیحات:**

- این پروژه آموزشی برای یادگیری بیشتر در این زمینه میباشد و امیدوارم به کار شما بیاید ( استفاده از آن بر عهده شما میباشد). اگردرخواست رفع باگی یا اضافه کردن feature ای داشتید تنها در قسمت Issues بیان کنید تا در صورت توان، مشکل را حل و درخواستی را اضافه کنم.
- در این پروژه در صورت نصب (نصب وارپ اجباری نمیباشد)، از وارپ پایه به صورت وایرگارد یا xray استفاده کردم تا بعدا ببینم چطور است اما فکر نکنم برای یوزر بالا مناسب باشد و این مورد یا برای استفاده شخصی مناسب باشد یا 5 نفر.(در صورت نیاز بعدا اپدیت میشود)
- نکته ای که باید به آن توجه کنید استفاده از systemd-resolved است. این مورد میتواند مشکلاتی در پنل شما به وجود اورد. اگر برای فعال کردن اینترفیس وایرگارد، مشکل dns داشتید.. dns را از اینترفیس وایرگارد حذف نمایید. به این صورت که nano /etc/wireguard/wg0.conf و قسمت DNS را حذف نمایید و ctrl + x را بزنید
- اطمینان حاصل کنید که قبل از نصب پنل، مشکل dns ندارید. سرور ریبیلد شده باشد و اگر مشکل dns داشتید از اوپتیمایزر ها استفاده نمایید‌.
- در این داشبورد از طریق خود پنل، امکان نصب بات تلگرام وجود دارد. باید دقت نمایید که نصب فارسی با نصب انگلیسی متفاوت میباشد و از قسمت مربوطه نصب نمایید
- در این پنل از json برای محدودیت حجم و مانیتورینگ استفاه شده است. 
- در این پنل امکان جابجایی فایل های پشتیبان از سروری به سرور دیگر امکان پذیر است تنها باید دقت کنید که نام اینترفیس وایرگارد را تغییر ندهید و اینترفیس اصلی eth یا ens در کانفیگ وایرگارد ذکر شود. به طور مثال اگر در سرور اول اینترفیس اصلی شما eth است در سرور دوم در صورت تغییر اینترفیس اصلی، ان را در wg0.conf ویرایش نمایید.
- در صورت تانل کردن وایرگارد چه با پورت فوروارد یا تانل های دیگر، باید دقت نمایید در صورت 92B در قسمت RX ممکن است مشکل شما با ریست کردن کامپیوتر خود و خالی کردن data storage و cache وایرگارد در موبایل خود حل شود و حتما به دلیل مشکل تانل یا پنل نمیباشد چون پنل کاری با تانل شما ندارد
- در این پنل تلاش کردم در حد توان از sanitazation و استفاده از مسیر اصلی دستورات استفاده بشود تا جای ممکن از shell injection جلوگیری شود.
- برای قالب یا template : میتوانید با قرار دادن قالب دلخواه خود در سایز 430 در 500 در static/images از قالب دلخواه خود استفاده نمایید.(در صورتی که پنل خوب کار کند و مشکل خاصی نباشد در اینده میشود این قسمت را Interactive کرد)
- توجه داشته باشید دکمه فعال و غیر فعال کردن، حجم و زمان هم ریست میکند و در بات هم به همین صورت است
- بعدا بررسی sanitization قبل از subprocess تکمیل خواهد شد که خطاهای bandit هم کم شود
- بر روی ubuntu 24 & debian 12 تست شده است
- دقت نمایید برای اینکه پنل و feature های حجم و زمان به درستی کار کند باید سرویس wireguard-panel همیشه بدون مشکل کار کند. بهتر است گهگاهی این سرویس را بررسی کنید. البته در صورت نصب بات، در صورت قطع سرویس به شما notify میشود.


----------------------------------

![check](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/13de8d36-dcfe-498b-9d99-440049c0cf14)
**امکانات و نکات**

- مدیریت حجم به صورت MiB , GIB
- مدیریت زمان به صورت روز و ماه و ساعت و دقیقه
- نمایش available ips برای اساس ایپی پرایوت انتخابی شما ( تنها 30 تا را به صورت همزمان در پنل نشان میدهد)
- استفاده از Json فایل برای پشتیبانی و مدیریت و مانیتورینگ
- امکان پشتیبان گیری اتوماتیک و دستی و بازگردانی آن
- نمایش اینترفیس وایرگارد و کاربران
- نمایش cpu و disk و ram در صفحه اصلی
- پشتیبانی از زبان فارسی و انگلیسی تنها با یک بار نصب
- دارای اسکریپت نصب
- دارای ربات ادمین برای ساخت و ویرایش کاربر و پشتیبان گیری و سایر موارد به زبان انگلیسی و فارسی ( از داخل پنل نصب میشود)
- دارای وارپ پایه به صورت wgcf و xray (به صورت ازمایشی اضافه شده است)
- امکان تغییر دادن تنظیمات وایرگارد و flask از داخل پنل
- پشتیبانی از tls توسط certbot
- دارای نمایش قالب default برای کاربران و qr code و دانلود کانفیگ
- دارای ریست حجم و زمان و دکمه های فعال یا غیر فعال کردن
- دارای pagination به این صورت که هر 10 کاربر در یک صفحه قرار میگیرد
- دارای نمایش لاگ و ایپی های سرور و سرویس بات و وارپ و غیره
- دارای نمایش notification برنامه در ربات ادمین
- دارای محاسبه زمان پس از اتصال اول
-------
  <div align="right">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/3cfd920d-30da-4085-8234-1eec16a67460" alt="Image"> آپدیت</strong></summary>
  
------------------------------------ 

- ربات فارسی و انگلیسی اپدیت شد که منو های compact mode داشته باشد
- اسکریپت اپدیت شد که با فراخوانی wire اجرا شود
- اپدیت app.py برای ریدایرکت صفحه register به لاگین در صورت وجود نام کاربری و گذرواژه ( thanks to opiran for mentioning that)
- اپدیت script-fa.js برای جل مشکل refresh peer list در هنگام فیلتر فعال.
  </details>
</div>

--------------------------------

![6348248](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/398f8b07-65be-472e-9821-631f7b70f783)
**آموزش نصب با اسکریپت**
 <div align="right">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/fcbbdc62-2de5-48aa-bbdd-e323e96a62b5" alt="Image"> </strong>نصب پنل و بات</summary>

------------------------------------ 

- اجرای اسکریپت دانلود
 
```
sudo apt update && sudo apt install -y curl && curl -fsSL -o download.sh https://raw.githubusercontent.com/Azumi67/Wireguard-panel/refs/heads/main/download.sh && bash download.sh
```


<p align="right">
  <img src="https://github.com/user-attachments/assets/3c70376b-330b-4ffe-b8f2-60ed18f80a30" alt="Image" />
</p>


- نخست گزینه ها را به ترتیب نصب میکنید تا به گزینه 4 برسید

<p align="right">
  <img src="https://github.com/user-attachments/assets/9a7379c1-f19d-491d-847d-de5342f2c218" alt="Image" />
</p>


- نخست پورت پنل خود را وارد میکنید و سایر موارد را در صورت منابع بهتر در صورت نیاز تغییر میدهید یا به صورت دیفالت به قسمت بعد میروید
- کلید رمز عبور برنامه را وارد نمایید
- در صورت نیاز از tls گزینه yes را وارد نمایید و در صورت نیاز نداشتن به این مورد گزینه No را وارد میکنید و بدون tls استفاده مینمایید
- در صورت وارد کردن yes برای tls، باید ساب دامین و ایمیل خود را وارد نمایید. اطمینان یابید که dns ساب دامین شما به درستی به ایپی سرور شما لینک شده است
- در صورت مشکل نصب، نصب certbot را به صورت دستی انجام دهید و سپس به این مرحله بازگردید
- در صورت استفاده نکردن از tls ادرس داشبورد شما http://publicip:port/home است و در صورت استفاده از tls به صورت https://subdomain:port/home خواهد بود

<p align="right">
  <img src="https://github.com/user-attachments/assets/5f861a94-bb47-4cd2-82ef-cf8c6d78a85c" alt="Image" />
</p>

- قسمت بعدی ست کردن کانفیگ وایرگارد میباشد
- همیشه با wg0 کانفیگ را اغاز کنید و سپس wg1 و wg2
- ایپی پرایوت ورژن 4 باشد و نیازی به ایپی 6 نمیباشد
- پورت و سایر موارد را وارد نمایید.
- در صورت استفاده از فایروال، پورت و رنج پرایوت را باز کنید
<p align="right">
  <img src="https://github.com/user-attachments/assets/c4ce3873-ebd3-435e-8a66-d66a9cf9f260" alt="Image" />
</p>


- این مورد برای اموزش است و تنها پس از نصب اسکریپت و داخل پنل انجام میشود. دقت نمایید که برای استفاده از ربات به زبان انگلیسی، نخست زبان پنل را انگلیسی کنید و سپس ربات را نصب نمایید. فارسی هم به همین صورت میباشد
- برای نصب بات از داخل پنل میتوانید انجام دهید. همان طور که در اسکرین شات مشاهده میکنید توکن باتی که از @BotFather دریافت کردید قرار دهید
- ادرس صفحه هم بر اساس استفاده از tls یا بدون آن خواهد بود. اگر بدون tls است باید http://publicip:port و در صورت آستفاده از tls باید https://subdomain:port قرار دهید
- قسمت بعدی همان کلید api است که از پنل دریافت کرده اید
- قسمت بعدی هم admin chat id رباتی که داخل botfather ساختید را دریافت میکنید . از طریق @userinfobot میتوانید نام ربات خود را بدهید و این مورد را بدست اوردید.
- سپس گزینه 6 و 7 اسکریپت را نصب کنید و پنل شما اماده است
- در صفحه اصلی ادرس داشبورد خود را مشاهده میکنید

------------------

  </details>
</div>  

 <div align="right">
  <details>
    <summary><strong><img src="https://github.com/Azumi67/Rathole_reverseTunnel/assets/119934376/fcbbdc62-2de5-48aa-bbdd-e323e96a62b5" alt="Image"> </strong>نصب پنل به صورت دستی</summary>

------------------------------------ 

- اجرای دستورات

<div align="left">
  
```
sudo apt update && sudo apt install git -y
cd /usr/local/bin
sudo git clone https://github.com/Azumi67/Wireguard-panel.git
cd /usr/local/bin/Wireguard-panel

sudo apt install -y python3 python3-pip python3-venv git redis nftables iptables wireguard-tools iproute2 \
    fonts-dejavu certbot curl software-properties-common wget

sudo systemctl enable redis-server.service
sudo systemctl start redis-server.service
sudo systemctl status redis-server.service

# creating env

python3 --version
sudo apt update && sudo apt install python3 python3-pip python3-venv
python3 -m venv /usr/local/bin/Wireguard-panel/src/venv
source /usr/local/bin/Wireguard-panel/src/venv/bin/activate
pip install --upgrade pip
pip install python-dotenv python-telegram-bot aiohttp matplotlib qrcode "python-telegram-bot[job-queue]" pyyaml flask-session Flask SQLAlchemy Flask-Limiter Flask-Bcrypt Flask-Caching jsonschema psutil requests pynacl apscheduler redis werkzeug jinja2 fasteners gunicorn pexpect cryptography Pillow arabic-reshaper python-bidi

sudo apt-get install -y libsystemd-dev
deactivate

# permissions

chmod 644 /usr/local/bin/Wireguard-panel/src/config.yaml
chmod -R 600 /usr/local/bin/Wireguard-panel/src/db
chmod -R 700 /usr/local/bin/Wireguard-panel/src/backups
chmod 644 /usr/local/bin/Wireguard-panel/src/telegram/telegram.yaml
chmod 644 /usr/local/bin/Wireguard-panel/src/telegram/config.json
chmod 644 /usr/local/bin/Wireguard-panel/src/install_progress.json
chmod 644 /usr/local/bin/Wireguard-panel/src/api.json
chmod 744 /usr/local/bin/Wireguard-panel/src/install_telegram.sh
chmod 744 /usr/local/bin/Wireguard-panel/src/install_telegram-fa.sh
chmod -R 644 /usr/local/bin/Wireguard-panel/src/static/fonts
chmod -R 644 /usr/local/bin/Wireguard-panel/src/telegram/static/fonts
chmod -R 755 /etc/wireguard

```

- Flask & gunicorn configuration :

```
nano /usr/local/bin/Wireguard-panel/src/config.yaml

###
flask:
  port: 8443
  tls: true
  cert_path: "/etc/letsencrypt/live/subdomain.com/fullchain.pem"
  key_path: "/etc/letsencrypt/live/subdomain.com/privkey.pem"
  secret_key: "azumi"
  debug: false

gunicorn:
  workers: 2
  threads: 1
  loglevel: "info"
  timeout: 120
  accesslog: ""
  errorlog: ""

wireguard:
  config_dir: "/etc/wireguard"
##

```

- Wireguard configuration :

```
nano /etc/wireguard/wg0.conf

##
[Interface]
Address = 166.66.66.1/25
ListenPort = 20821
PrivateKey = aBY+lbhuOlBknLDDi2MbI11LZKEDGOSsvIbWQDuCSX0=
MTU = 1380
DNS = 1.1.1.1

PostUp = iptables -I INPUT -p udp --dport 20821 -j ACCEPT
PostUp = iptables -I FORWARD -i eth0 -o wg0 -j ACCEPT
PostUp = iptables -I FORWARD -i wg0 -j ACCEPT
PostUp = iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

PostDown = iptables -D INPUT -p udp --dport 20821 -j ACCEPT
PostDown = iptables -D FORWARD -i eth0 -o wg0 -j ACCEPT
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT
PostDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

##

Commands for generating private & pub key :
wg genkey | tee privatekey
cat privatekey | wg pubkey > publickey


```

- Wireguard panel service
```
nano /etc/systemd/system/wireguard-panel.service

##
[Unit]
Description=Wireguard Panel
After=network.target

[Service]
User=root
WorkingDirectory=/usr/local/bin/Wireguard-panel/src
ExecStart=/usr/local/bin/Wireguard-panel/src/venv/bin/python3 /usr/local/bin/Wireguard-panel/src/app.py
Restart=always
Environment=PATH=/usr/local/bin/Wireguard-panel/src/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
Environment=LANG=en_US.UTF-8
Environment=LC_ALL=en_US.UTF-8

[Install]
WantedBy=multi-user.target

##
```
------------------------------------ 

  </details>
</div>  

---------------
**اسکرین شات**
<details>
  <summary align="right">پنل</summary>
  
  <p align="right">
    <img src="https://github.com/user-attachments/assets/cb754472-6a4a-4511-acde-b037737b600f" alt="menu screen" />
  </p>
</details>
<details>
  <summary align="right">ساخت کاربر</summary>
  
  <p align="right">
    <img src="https://github.com/user-attachments/assets/d8b799b5-8825-4079-bfbb-e68c9fa1c7c5" alt="menu screen" />
  </p>
</details>
<details>
  <summary align="right">باکس کاربر</summary>
  
  <p align="right">
    <img src="https://github.com/user-attachments/assets/ec328904-6e78-4536-a08b-600f3a0c6a64" alt="menu screen" />
  </p>
</details>
<details>
  <summary align="right">بات</summary>
  
  <p align="right">
    <img src="https://github.com/user-attachments/assets/39c96321-2148-4ca8-88fe-f995b9525487" alt="menu screen" />
  </p>
</details>

-----------------------------------------------------

![R (a2)](https://github.com/Azumi67/PrivateIP-Tunnel/assets/119934376/716fd45e-635c-4796-b8cf-856024e5b2b2)
**اسکریپت دانلود**
----------------


```
sudo apt update && sudo apt install -y curl && curl -fsSL -o download.sh https://raw.githubusercontent.com/Azumi67/Wireguard-panel/refs/heads/main/download.sh && bash download.sh

```

- باز فراخوانی اسکریپت
```
wire
```

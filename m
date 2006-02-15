From: vr@aradio.ru (Victor A. Bykov)
Date: Wed, 15 Feb 2006 11:29:17 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <035501c63223$0e8cf200$5964a8c0@office.aradio.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
In-Reply-To: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"?????????"
????:  lm-sensors at lm-sensors.org
       Jean Delvare
??: ????????? ????????????? ????? ?????? ?????????
????: Re: [lm-sensors] w83781d and empty /sys/class/hwmon

Hi, Jean

>> But directory /sys/class/hwmon is empty, and sensors -s does not work!
>Does the device show under /sys/bus/i2c/devices?
/sys/bus/i2c/devices is empty too 

but there is simlink to device in /sys/class/i2c-dev/i2c-0

>Does "sensors" (without -s) work?
no, it does not (strace shows it tries to read /sys/class/hwmon and exits with error)



????/?????: 15.02.2006 14:29:25
???????: + 7 (495) 258-33-44
E-mail: vr at aradio.ru
??? ????: http://www.avtoradio.ru


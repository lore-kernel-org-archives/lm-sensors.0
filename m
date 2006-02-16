From: vr@aradio.ru (Victor A. Bykov)
Date: Thu, 16 Feb 2006 08:01:30 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <03d001c632cf$32078310$5964a8c0@office.aradio.ru>
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


>> > Which motherboard is this?
>>
>> It says "Version: ASUS P3B-F ACPI BIOS Revision 1006 "

>The dump you provided looks OK to me, the w83718d driver should work >fine

here's debug when loading w83781d

Feb 16 10:56:18 gw kernel: i2c-core: driver [w83781d] registered
Feb 16 10:56:18 gw kernel: i2c_adapter i2c-0: found ignore parameter for adapter 0, addr 0x2d
Feb 16 10:56:18 gw kernel: i2c_adapter i2c-9191: Driver w83781d-isa registered
Feb 16 10:56:18 gw kernel: i2c_adapter i2c-9191: Detection of w83781d chip failed at step 2 (0x7f != 0x0 at 0x295)



????/?????: 16.02.2006 11:01:35
???????: + 7 (495) 258-33-44
E-mail: vr at aradio.ru
??? ????: http://www.avtoradio.ru


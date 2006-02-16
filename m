From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Feb 2006 08:53:26 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <GNeod1q7.1140080006.1537810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
In-Reply-To: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Victor,

> here's debug when loading w83781d
>
> Feb 16 10:56:18 gw kernel: i2c-core: driver [w83781d] registered
> Feb 16 10:56:18 gw kernel: i2c_adapter i2c-0: found ignore parameter for
>                            adapter 0, addr 0x2d

You are explicitely preventing the driver to attach to device 0,0x2d
which is precisely your AS99127F chip! No wonder sensors then doesn't
work.

How is the w83781d driver loaded? Check your init scripts, and
double-check /etc/modprobe.conf. There *must* be an "ignore=0,0x2d"
parameter passed to the w83781d driver somehow, and you have to get rid
of it. "sensors" should then work just fine.

--
Jean Delvare


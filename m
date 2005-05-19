From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: A probelm of loading module i2c-ali1563.o
Message-Id: <XxmK8d7z.1105617992.0405350.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <265EC8B67800A345A8FB8CA013220F0119E39D@wehqml01>
In-Reply-To: <265EC8B67800A345A8FB8CA013220F0119E39D@wehqml01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

> While I'm trying to load the module of the south bridge chip (ULI M1563
> B1), it shows
>[root@localhost busses]# insmod ./i2c-ali15x3.o
>./i2c-ali15x3.o: init_module: No such device

Expected, since the M1563 is not supported by this driver.

> Is there any module named "i2c-ali1563"? I only found "i2c-ali15x3".
>
> Does i2c-2.8.8 support this chipset of ULi?

There is an i2c-ali1563 driver specifically written by Patrick Mochel for
the M1563, but only available for Linux 2.6 at the moment:
http://archives.andrew.net.au/lm-sensors/msg26537.html

You would need to port it back to 2.4 (i.e. to lm_sensors CVS). Patrick
seems to think this would be easy.

--
Jean Delvare

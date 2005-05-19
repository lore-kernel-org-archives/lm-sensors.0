From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: i2c-core on 2.6.0-test10
Message-Id: <20031127195752.7ff4c540.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069707536.1010.8.camel@phoebus>
In-Reply-To: <1069707536.1010.8.camel@phoebus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I use newwest 2.6 test10 kernel, i have MB based on Apollo 133
> chipset,
> 
>  i compiled into kernel i2c support, i2c algobit, viapro,
>  i2c_isa,via686a,eeprom.

You probably don't need i2c-algo-bit, but you could compile w83781d in.
I have a board with a KT133 and the via868a chip is not used, instead
there is an as99127f (this is an Asus board) which is handled by the
w83781d driver.

> Also i downloaded 21th november cvs lm_sensors2 and compiled user
> tools only

I invite you to update. Significant changes have been made, that could
solve your problems.

> The problem is that sensors dont see any sensors on isa
> bus. As i remeber (and as sensors-detect writes) i need i2c_core to
> maitain /proc/bus/i2c??? but there are no such directories... 

/proc is for 2.4 kernels. In 2.6 we use sysfs, usually under /sys.
Make sure you have sysfs support enabled and /sys mounted, and with
up-to-date tools you should get your values back.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

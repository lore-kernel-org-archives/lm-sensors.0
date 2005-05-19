From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: modprobe i2c-elv failed
Message-Id: <20030720111842.318e4800.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1057129728.43058.vincente@mail2000.com.tw>
In-Reply-To: <1057129728.43058.vincente@mail2000.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have install i2c-2.7.0 in my system ( kernel 2.4.20 ).
> when I load i2c-elv it show me:
> 
> [root@localhost i2c-2.7.0]# modprobe i2c-elv
> /lib/modules/2.4.20/kernel/drivers/i2c/i2c-elv.o: init_module: No such
> device Hint: insmod errors can be caused by incorrect module
> parameters, including invalid IO or IRQ
> parameters/lib/modules/2.4.20/kernel/drivers/i2c/i2c-elv.o: insmod
> /lib/modules/2.4.20/kernel/drivers/i2c/i2c-elv.o
> failed/lib/modules/2.4.20/kernel/drivers/i2c/i2c-elv.o: insmod i2c-elv
> failed
> 
> /var/log/message shows :
> 
> Jul  2 15:08:40 localhost kernel: i2c-algo-bit.o: i2c bit algorithm
> module version 2.7.0 (20021208) Jul  2 15:08:40 localhost kernel:
> i2c-elv.o: i2c ELV parallel port adapter module version 2.7.0
> (20021208)
> 
> My mainboard is tyan 2723.
> Is it somthing wrong?

No, you just don't have this adapter on your system. This isn't a very
usual adapter, so no need to wonder. I never had it on any of my
machines.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

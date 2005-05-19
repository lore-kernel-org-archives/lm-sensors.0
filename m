From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Asus A7A266 and lm_sensors
Message-Id: <3E2CAEAD.3010900@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E21D96A.2080201@metalhen.de>
In-Reply-To: <3E21D96A.2080201@metalhen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I assume you are using the force_addr parameter as recommended in dmesg.
We know about the "command never completed" problem but don't
have a fix because we don't have a datasheet.
Be sure that you have a chip supported by the w83781d driver
(look at your board)
Don't load the parallel port drivers, they aren't helping.

Benjamin Henne wrote:
> Hi.
> I tried to install and use lm_sensors for my server at home.
> It has an Asus A7A266-Board.
> 
> The detect and the infos at
> http://www.cs.utexas.edu/users/bdbryant/howtos/hardware/asus-a7a266/lm_sensors/ 
> 
> said
> to use the module w83781d. But I can't use it?
> I tried something...
> 
> modprobe i2c-ali1535    is OK
> 
> modprobe w83781d
> (and lm75)
> 
> make my PC do a never ending high tone beep. I only can shut down then 
> (system hangs at umount)
> 
> and: I alwys had "no sensors found"
> 
> do you have some Ideas/Hints for me??
> 
> 
> 
> my
> /var/log/messages:
> 
> 
> Jan 12 21:32:23 server kernel: i2c-core.o: i2c core module version 2.7.0 
> (20021208)
> Jan 12 21:32:23 server kernel: i2c-ali15x3.o version 2.7.0 (20021208)
> Jan 12 21:32:23 server kernel: i2c-ali15x3.o: ALI15X3_smb region 
> uninitialized - upgrade BIOS or use force_addr=0xaddr
> Jan 12 21:32:23 server kernel: i2c-ali15x3.o: ALI15X3 not detected, 
> module not inserted.
> Jan 12 21:32:27 server kernel: i2c-core.o: i2c core module version 2.7.0 
> (20021208)
> Jan 12 21:32:27 server kernel: i2c-ali1535.o version 2.7.0 (20021208)
> Jan 12 21:32:27 server kernel: i2c-ali1535.o: ALI1535 SMBus Controller 
> detected and initialized
> Jan 12 21:32:29 server kernel: i2c-algo-bit.o: i2c bit algorithm module 
> version 2.7.0 (20021208)
> Jan 12 21:32:29 server kernel: i2c-voodoo3.o version 2.7.0 (20021208)
> Jan 12 21:32:29 server kernel: i2c-voodoo3: Using Banshee/Voodoo3 at 
> 0xd0921000
> Jan 12 21:32:29 server kernel: i2c-voodoo3: 1 Banshee/Voodoo3 found.
> Jan 12 21:32:29 server kernel: i2c-voodoo3.o: I2C bus initialized
> Jan 12 21:32:29 server kernel: i2c-voodoo3.o: DDC bus initialized
> Jan 12 21:32:33 server kernel: i2c-algo-pcf.o: i2c pcf8584 algorithm 
> module version 2.7.0 (20021208)
> Jan 12 21:32:33 server kernel: i2c-elektor.o: i2c pcf8584-isa adapter 
> module version 2.7.0 (20021208)
> Jan 12 21:32:35 server kernel: i2c-elv.o: i2c ELV parallel port adapter 
> module version 2.7.0 (20021208)
> Jan 12 21:32:36 server kernel: i2c-philips-par.o: i2c Philips parallel 
> port adapter module version 2.7.0 (20021208)
> Jan 12 21:32:36 server insmod: 
> /lib/modules/2.4.18-14/kernel/drivers/parport/parport_pc.o: init_module: 
> Device or resource bus
> y
> Jan 12 21:32:36 server insmod: Hint: insmod errors can be caused by 
> incorrect module parameters, including invalid IO or IRQ p
> arameters.       You may find more information in syslog or the output 
> from dmesg
> Jan 12 21:32:36 server insmod: 
> /lib/modules/2.4.18-14/kernel/drivers/parport/parport_pc.o: insmod 
> parport_lowlevel failed
> Jan 12 21:32:38 server kernel: i2c-velleman.o: i2c Velleman K8000 
> adapter module version 2.7.0 (20021208)
> Jan 12 21:32:42 server kernel: i2c-dev.o: i2c /dev entries driver module 
> version 2.7.0 (20021208)
> Jan 12 21:32:45 server kernel: i2c-ali1535.o: Error: command never 
> completed
> Jan 12 21:32:46 server last message repeated 123 times
> Jan 12 21:33:56 server kernel: i2c-ali15x3.o version 2.7.0 (20021208)
> Jan 12 21:33:56 server kernel: i2c-ali15x3.o: ALI15X3_smb region 
> uninitialized - upgrade BIOS or use force_addr=0xaddr
> Jan 12 21:33:56 server kernel: i2c-ali15x3.o: ALI15X3 not detected, 
> module not inserted.
> Jan 12 21:33:59 server kernel: i2c-algo-pcf.o: i2c pcf8584 algorithm 
> module version 2.7.0 (20021208)
> Jan 12 21:33:59 server kernel: i2c-elektor.o: i2c pcf8584-isa adapter 
> module version 2.7.0 (20021208)
> Jan 12 21:34:02 server kernel: i2c-velleman.o: i2c Velleman K8000 
> adapter module version 2.7.0 (20021208)
> Jan 12 21:34:03 server kernel: i2c-ali1535.o: Error: command never 
> completed
> Jan 12 21:34:04 server last message repeated 123 times
> Jan 12 21:36:23 server kernel: i2c-proc.o version 2.7.0 (20021208)
> Jan 12 21:36:23 server kernel: w83781d.o version 2.7.0 (20021208)
> Jan 12 21:36:23 server kernel: i2c-ali1535.o: Error: command never 
> completed
> Jan 12 21:36:23 server last message repeated 14 times
> 
> 

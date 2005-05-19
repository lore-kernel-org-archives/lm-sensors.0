From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F6@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I found this on Google,

http://www.gelato.unsw.edu.au/linux-ia64/0201/2712.html

and tried making the suggested change (or as close as I could guess), but it didn't help,

[root@gb0010 hotplug]# modprobe i2c-piix4
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/busses/i2c-piix4.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/busses/i2c-piix4.o: insmod /lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/busses/i2c-piix4.o failed
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/busses/i2c-piix4.o: insmod i2c-piix4 failed

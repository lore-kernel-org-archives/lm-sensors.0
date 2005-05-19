From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Why this output?
Message-Id: <20021114111102.07bd4fc9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F92C49.4411%zdavatz@ywesee.com>
In-Reply-To: <B9F92C49.4411%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved
> symbol iounmap_Rsmp_5fb196d4
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved
> symbol__ioremap_Rsmp_9eac042a
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved
> symbol printk_Rsmp_1b7d4074
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: unresolved
> symbol kmalloc_Rsmp_93d4cfe6
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: insmod
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o failed
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o: insmod

> Any idea what this onresolved symbol is doing?

My first guess is that you forgot to run "depmod -a" after installing
lm_sensors. So, try to run (as root) "depmod -a" and see what happens.
If nothing happens, it's alright and you should be able to run
sensors-detect.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

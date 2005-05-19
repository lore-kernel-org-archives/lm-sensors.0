From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Additional Support: Ticket 1548
Message-Id: <1075280333.401779cd67e35@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040128025905.42866.qmail@web20902.mail.yahoo.com>
In-Reply-To: <20040128025905.42866.qmail@web20902.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> When I don't load eeprom, and do the modprobes as root
> after a fresh boot, I get a bizarre message:
> 
> $ modprobe w83627hf
> modprobe: Can't locate module w83627hf

This probably means that your distribution doesn't include the driver
you need for your hardware. Either ask them for an update, or install
it yourself from our source package. You'll need the source tree
matching your running kernel present and configured (if your
distribution has a "kernel-source" package, that's what you want).
Then, compile lm_sensors with "make" and copy the driver from
kernel/chips/w83627hf.o to the place your distribution is storing the
drivers (/lib/modules/2.4.22-26mdk/kernel/drivers/i2c/chips/ or
something similar). Run "depmod -ae" to make sure everything's OK, and
you should be able to modprobe w83627hf.

As for the errors you got when running sensors-detect, I suspect that
Mandrake added changes of their own to our script. Please get our
original script (either from the 2.8.3 package you'll have downloaded,
of from CVS here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect)
and confirm if the error still occurs. If it does, I'll investigate.

Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

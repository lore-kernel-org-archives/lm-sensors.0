From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: modprobe fails on i2c-piix4
Message-Id: <20030322101001.08b300bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c2e8df$d6184120$fefaa8c0@einstein>
In-Reply-To: <000001c2e8df$d6184120$fefaa8c0@einstein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Downloaded 2.7.0 of lm_sensors and 2.7.0 of i2c and compiled on a
> RedHat 7.3 with kernel/source 2.4.18-26.7
> 
> "make" and "make install" works fine, but when doing a depmod -ae the
> following is logged:
> 
> [root@santa 2.4.18-26.7.x]# depmod -ae
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.18-26.7.x/kernel/drivers/i2c/i2c-piix4.o
> depmod:         dmi_scan_mach
> depmod:         dmi_ident
> 
> I see that the i2c-piix4 module is part of the lm_sensors code, and
> not the i2c code. So even after doing a make and make install on the
> lm_sensors code, depmod -a still fails with the same error as above.
> 
> I also see that the dmi_scan.c is not compiled during lm_sensor
> compilation. All other objects are generated in the
> ./lm_sensors-2.7.0/kernel/busses.
> 
> I also get a lot of "grep: /lib/modules/2.4.18-26.7.x/build/.config:
> No such file or directory" when issuing make on both i2c and
> lm_sensors. It still compiles without errors.
> What could be causing this?

I think you may simply be missing the kernel sources that match the
kernel you're running. We need a proper kernel tree in order to compile
i2c and lm_sensors (we need some kernel headers). Usually, the kernel
sources are in /usr/src/linux-*. We find the exact location through a
symbolic link found in /lib/modules/<kernel version>/. Please check in
your lib/modules/2.4.18-26.7.x/ directory if there is a "build" symbolic
link. There should be one, pointing to /usr/src/linux-2.4.18 or
something similar. If there is one, but the target directory doesn't
exist, this means you are supposed to install some package (kernel or
kernel-headers). If there isn't one, but you have a kernel directory,
you could just create the symbolic link yourself. Just remember that the
kernel sources, including the config file, are supposed to match the
running kernel (or at least the kernel for which you are building the
i2c and lm_sensors drivers).

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

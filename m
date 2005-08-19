From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 19 Aug 2005 17:38:33 +0000
Subject: [lm-sensors] A few remarks about the w83792d
Message-Id: <4305FCE8.6040602@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43045711.6040804@fr.thalesgroup.com>
In-Reply-To: <43045711.6040804@fr.thalesgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> we are starting to use the driver on our machines and we noticed to
> things that we feel should be changed :
>  - the values in /etc/sensors.conf for the CPU temperature threshold are
> very low (max:42? hyst:37?). This supersed the values set in the BIOS
> and is very low, causing the PC to beep everytime the CPU is loaded at 100%
>  - when we read the sensors with sensors, we see the following message

Ahh correct. I will comment it out in example config. Must remained from driver testing.
I will fix it in CVS.

> on the console :
>  w83792d 0-002f: Starting device update.

Yes this was already fixed. The driver is now in -mm tree of linux and perhaps will show up in 2.6.14 kernel.
Also the driver now contains latest sysfs subsystem updates and some cleanups. What was paticulary changed
can be seen here: http://assembler.cz/download/w83792d/ (please note that this is not exactly what is in kernel now)

I assume your customer is not running latest kernel so here is the list what you should fix:

0) fix for this update issue (should fix)
1) fix detection probe range (should fix)
2) fix subclient registration (if you want to handle special cases when some of subclients are disabled in HW)
3) fix documentation (should fix)

Fix for 0)
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050706/3a674472/w83792d-driver-QUIET-2.6.x.patch-0001.gz
(in this thread http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/012919.html)

Fix for 1)

Please add two more addresses so it looks like this:

+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };

Fix for 2)

This patch is for modified driver but you should get the idea.
http://assembler.cz/download/w83792d/04-fix-disabled-subclients

Here you can read more about this:
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/012940.html

Fix for 3)

Contact at Winbond has been changed. Please ship this version of documenation
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013099.html

>  thank you for your help and your work on lmsensors !

Ahh it always makes me happy :)

Regards

Rudolf

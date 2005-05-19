From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <yLKFpvUU.1107518117.7806190.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> Provided that I have successfully ported w83792d.c from linux-2.4 to 2.6,
> How should I add it into the linux kernel tree linux-2.6.10 for test?
> I have tried the following steps:
> (1)Add a file w83792d.c into the directory
>   /usr/src/linux-2.6.10/drivers/i2c/chips/

Correct.

> (2) modify /usr/src/linux-2.6.10/drivers/i2c/chips/Makefile (add 792 part)

Correct again.

> (3) modify /usr/src/linux-2.6.10/.config (add 792 part)

Not correct. You need to edit
/usr/src/linux-2.6.10/drivers/i2c/chips/Kconfig, where you'd add a
section for the w83792d driver, just copy, paste and edit from another
chip's section.

Once done, use "make oldconfig" or "make menuconfig" to enable the
new driver, preferably as a module. You can edit .config manually but
that's definitely not the easiest way!

> Btw, the Documentation/i2c/writing-clients in linux-2.6.10 and 
> linux-2.6.11-rc3 is NOT for linux-2.6, but for linux-2.4. You need to
> update it.

You are right, this file is severly outdated, and would need an update.
Probably not everything needs to be, the overall structure of the
document seems correct, the major change would be to remove all
references to procfs and replace with sysfs info. Feel free to propose a
corrective patch for that file!

Thanks,
--
Jean Delvare

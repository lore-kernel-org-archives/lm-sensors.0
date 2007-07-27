From: "Jean Delvare" <khali@linux-fr.org>
Date: Fri, 27 Jul 2007 08:07:45 +0000
Subject: Re: [lm-sensors] [PATCH] Fix regression caused by typo in lm90.c
Message-Id: <BbJeFUOL.1185523665.8121830.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20070726230422.2955.70451.sendpatchset@localhost.localdomain>
References: <20070726230422.2955.70451.sendpatchset@localhost.localdomain>
In-Reply-To: <20070726230422.2955.70451.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: guichaz@yahoo.fr, mhoffman@lightlink.com
Cc: Rainer Birkenmaier <rainer.birkenmaier@siemens.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


Hi Guillaume,

On 7/26/2007, "Guillaume Chazarain" <guichaz@yahoo.fr> wrote:
>The commit http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h2c82a934759b2c9939c9e25865c2d7d1204b9e8
>broke lm90 for my (Asus V6VA) laptop.
>
>Before 2.6.23-rc1 and with the following patch, I get:
>
>[g ~]$ sensors
>max6657-i2c-0-4c
>Adapter: SMBus I801 adapter at 0400
>M/B Temp:    +64°C  (low  =    +0°C, high =  +127°C)
>CPU Temp:  +78.9°C  (low  = +73.2°C, high = +88.2°C)
>M/B Crit:   +105°C  (hyst =   +95°C)
>CPU Crit:   +105°C  (hyst =   +95°C)
>
>Which regressed into:
>
>[g ~]$ sensors
>No sensors found!
>Make sure you loaded all the kernel drivers you need.
>Try sensors-detect to find out which these are.
>zsh: 2701 exit 1     sensors
>
>and dmesg contains:
>
>i2c-adapter i2c-0: Unsupported chip (man_id=0x4D, chip_id=0x4D).
>
>It seems to be a typo, as address 0X4F is mentionned nowhere else in the
>file, and my chip is actually at 0x4C.

You are right :( Sorry for missing it.

>Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
>---
>
>diff -r 4cad6fced1a8 drivers/hwmon/lm90.c
>--- a/drivers/hwmon/lm90.c	Thu Jul 26 13:44:58 2007 -0700
>+++ b/drivers/hwmon/lm90.c	Tue Jul 24 00:02:52 2007 +0200
>@@ -585,7 +585,7 @@ static int lm90_detect(struct i2c_adapte
> 			 * those of the man_id register.
> 			 */
> 			if (chip_id = man_id
>-			 && (address = 0x4F || address = 0x4D)
>+			 && (address = 0x4C || address = 0x4D)
> 			 && (reg_config1 & 0x1F) = (man_id & 0x0F)
> 			 && reg_convrate <= 0x09) {
> 			 	kind = max6657;

Signed-off-by: Jean Delvare <khali@linux-fr.org>

Mark, please apply.

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

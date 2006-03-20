From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Mon, 20 Mar 2006 00:10:50 +0000
Subject: [lm-sensors] [PATCH] Hardware monitoring support for SMSC
Message-Id: <200603200110.51041.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603192325570.3062@Laila>
In-Reply-To: <Pine.LNX.4.63.0603192325570.3062@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> This patch adds a new driver (smsc47m192.o) which supports voltage and
> temperature measurement features of SMSC LPC47M192 and LPC47M997 chips.

This version doesn't load module on my system MSI RS480M2-IL with
patch applied on vanilla kernel 2.6.15.6.
Older version from smsc47m192_patch_2615.txt file works great.
There are errors from modprobe and dmesg:
---------------------------------
linux# modprobe smsc47m192

FATAL: Error inserting smsc47m192 
(/lib/modules/2.6.15.6/kernel/drivers/hwmon/smsc47m192.ko): Permission denied
---------------------------------
linux# dmesg
kobject_register failed for  (-13)

Call Trace:<ffffffff80200226>{kobject_register+70} 
<ffffffff80269e15>{bus_add_driver+101}
       <ffffffff8818855b>{:i2c_core:i2c_add_driver+107} 
<ffffffff80150e54>{sys_init_module+244}
       <ffffffff8010eb9a>{system_call+126}
---------------------------------

Best regards,

Pavel Ruzicka


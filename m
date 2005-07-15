From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 15 Jul 2005 11:57:21 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <20050715115642.7cb801e0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timothy,

> I've followed your instructions (thankyou!) and it's come up with a 
> "Success!" line! Hooray!
> Following the instructions, I didnt have a module.conf, so I added it
> to my modprobe.conf instead. There was nothing specific about the
> second bit, so I put it in /etc/rc.d/rc.local
> 
> When I rebooted I got the following:
> FATAL: Module w83627ehf not found.
> 
> I'm running 2.6.12-1_1390_FC4smp kernel, so I ran a "make menuconfig" 
> and it was chosen as a module, (...)

I doubt that. The w83627ehf driver is new in 2.6.13-rc1.

> (...) but I got all sorts of errors when I 
> tried a "make modules" and doing a "find ..." under the kernel source
> I couldnt find anything containing 83267 in the filename, so I might
> be missing some pieces.

This is 627, not 267.

> I really didnt want to start customising my
> kernel  though! Someone on fedoraforum.org suggested I try the
> w83627hf driver  which I did as follows:
> 
> [root@localhost rc.d]# modprobe w83627hf
> FATAL: Error inserting w83627hf 
> (/lib/modules/2.6.12-1.1390_FC4smp/kernel/drivers/i2c/chips/w83627hf.ko):
> No such device

There are two different drivers: the original w83627hf driver supports
the W83627HF, W83627THF, W83637HF and W83697HF chips. The new w83627ehf
driver (partly) supports the W83627EHF chip, and possibly the W83627EHG
as well. All these drivers and chips have very similar names so you have
to pay attention to which driver supports exactly what chips.

The driver you need is really the new w83627ehf driver. You will have to
either upgrade your kernel to 2.6.13-rc1 or later, or backport the
w83627ehf driver to the kernel you are using (we can help you do so, it
should be easy.) The least intrusive approach would be to compile the
backported driver outside of the kernel tree. Let us know if you want to
do that.

> Anyway, here's the long-winded output from sensors-detect:
> [root@localhost ~]# ./sensors-detect
> (...)
> Probing for `Winbond W83627EHF Super IO Sensors'
>   Success... found at address 0x0290

This means that your chip has an ID similar to those of the W83627EHF.
I'd like to know the exact 16-bit ID though, in case we need to
differenciate between both chips in the driver. Could you possibly get
isadump from lm_sensors 2.9.1 or CVS, and run the following command:

isadump -y -k 0x87,0x87 0x2e 0x2f 0x0b

This should give us the exact ID.

Thanks,
-- 
Jean Delvare

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 24 May 2006 15:07:34 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <447476B6.4090109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I remember I did some patch for 2.6 kernel for this.

Maybe it is missing for 2.4?

Anyway please supply output of following:

modprobe i2c-dev
i2cdetect 0
i2cdump 0 0x2f

I have the motherboard with this chip thanks to ASUS and Winbond so I can help you.

> May 24 07:06:54 ImageServer kernel: dmi_scan.o version 2.10.0 (20060214)
> May 24 07:06:54 ImageServer kernel: dmi_scan.o: SM BIOS found
> May 24 07:06:54 ImageServer kernel: i2c-piix4.o version 2.10.0 (20060214)
> May 24 07:06:54 ImageServer kernel: i2c-i801 version 2.10.0 (20060214)
> May 24 07:06:54 ImageServer kernel: i2c-isa.o version 2.10.0 (20060214)
> May 24 07:06:54 ImageServer kernel: w83781d.o version 2.10.0 (20060214)
> May 24 07:06:55 ImageServer kernel: w83792d version 2.10.0 (20060214)
> May 24 07:06:55 ImageServer kernel: w83792d: Subclients have the same 
> address (0x48)! Use force_subclients.
> May 24 07:06:55 ImageServer kernel: w83792d.o: Subclient 1 registration 
> at address 0x48 failed.
> May 24 07:06:55 ImageServer kernel: w83627hf.o version 2.10.0 (20060214)

This means that there was some misprogramming done by BIOS which put two other
sublients to same addr. The subclients are legacy LM75 like chips emulated by
w83792d.

Please let me know if
modprobe w83792d force_subclients=0,0x2f,0x4a,0x4b

Will work. the first 0 is the bus number. (I assume it as 0, please change it
for i2cdump too if it is different)

This also assumes that 0x4A and 0x4B are empty (very likely)

The cmd parameter was taken from 2.6 kernel Documentation/hwmon/w83792d file. I
belive we have similar for 2.4 in lm-sensors package.

Anyway, hope this helps. Plus let us know the output of dumps so I can reproduce
and eventually fix the driver.

Regards
Rudolf


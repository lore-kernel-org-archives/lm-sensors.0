From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Nov 2008 17:33:59 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <20081105183359.5dc3e963@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081101103904.7ea43d94@hyperion.delvare>
In-Reply-To: <20081101103904.7ea43d94@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter,

Sorry for the late answer, I fell ill and had to stay in bad for a
couple days.

On Sun, 02 Nov 2008 12:25:25 +0100, Peter Mahlknecht wrote:
> > OK. This confirms that ACPI is using the SMBus so we shouldn't. With
> > kernels >= 2.6.27, you can boot with parameter
> > acpi_enforce_resources=strict and the i2c-i801 driver will decline
> > attaching to the SMBus.
> 
> Has this the same effect as just not loading the i2c-i801 driver? Or
> what other functions then attaching to the SMBus has the i2c-i801?

This has roughly the same effect, yes. The only difference is that
acpi_enforce_resources=strict doesn't prevent the i2c-i801 driver from
loading, so it still appears in "lsmod" and wastes a small amount of
memory. But I doubt you really care in practice.

> > Another test I'd like you to do is:
> > 
> > # rmmod em28xx_cx25843
> > # rmmod lm90
> > # modprobe i2c-i801
> > # modprobe i2c-dev
> > # i2cdetect -l
> > (find the i2c bus number for "SMBus I801 adapter at 18e0")
> > # i2cdetect n
> > (where n is the bus number in question)
> > 
> > I wonder if this will confuse ACPI the same way loading em28xx_cx25843
> > does.
> 
> It does:
> laptop-mali:/home/mali# i2cdetect -l
> i2c-0	smbus     	SMBus I801 adapter at 18e0      	SMBus adapter
> laptop-mali:/home/mali# cat /proc/acpi/thermal_zone/THRM/temperature 
> temperature:             41 C
> laptop-mali:/home/mali# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- 
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 30: 30 -- 32 -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- 4c -- -- -- 
> 50: 50 -- 52 -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- -- 
> laptop-mali:/home/mali# cat /proc/acpi/thermal_zone/THRM/temperature 
> temperature:             65535 C

OK, so the mere fact of probing the bus with "SMBus quick commands" is
enough to confuse ACPI. I guess that the i2c-i801 driver is changing
some hardware settings (.e.g. SMBus vs. I2C timing or PEC flag) to
something ACPI doesn't expect. If we want the i2c-i801 driver to ever
cooperate on hardware like yours, we will have to teach the i2c-i801
driver how to only touch the configuration registers when it needs to
and how to restore all the settings when it is done. But at the moment
there is no safe way to do this anyway so I won't spend time on this.
The back-listing should work well enough.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

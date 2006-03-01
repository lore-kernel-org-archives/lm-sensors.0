From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 01 Mar 2006 19:19:18 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <20060301201918.ab898494.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bruce,

> I'd like to get lm_sensors support for a system with an HT1000 chip.
> References are on http://www2.lm-sensors.nu/~lm78/newdrivers.html
> 
> -- I've rebuilt a stock 2.6.15.4 kernel using the HT1000 patch referenced
>     on the newdrivers page:
>     http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-piix4-add-ht1000-support.patch
> 
> -- I then built and installed sysfsutils-2.0.0
> 
> -- I then built and installed lm_sensors-2.10.0.
> 
> -- I loaded the i2c_piix4 module using modprobe.
> 
> -- I mounted sysfs on /sysfs
> 
> However sensors-detect does not find ANYTHING.  Not even eeprom!  Am I 
> doing something stupid?

The HT-1000 is (from our simplified point of view) an SMBus master. It
may give you access to I2C/SMBus hardware monitoring chips, but isn't
itself a hardware monitoring chip.

> (Note: for kicks I also went into the lm_sensors source and 'hacked' the 
> SERVERWORKS CSB6 0x0203 PCI-id to be 0x0205 both the sensors-detect script 
> and in the i2c_piix4 code contained there. It didn't help.)

The i2c-piix4 driver found in the lm_sensors is a Linux 2.4 driver, so
it is of no use to you.

Adding the ID to sensors-detect will let it autoload the i2c-piix4
driver, but given that you had manually loaded it beforehand anyway, it
did not change anything for you.

Please check your logs after loading the i2c-piix4 driver. Did it
complain of anything?

Second, please provide the full output of sensors-detect. There are
many possible reasons why no chips were found on your HT-1000, and this
output should help us sort through them. You may also provide the
output of "i2cdetect 0" (assuming that the HT-1000 is the only i2c
adapter on the system; if not try "i2cdetect -l" first.)

> One other possibility is that because I have a BMC card plugged in to the 
> motherboard (SuperMicro H8SSL-i) the BMC card is not allowing access to 
> the devices from lm_sensors.

BMC are handled by a different set of drivers which were not yet merged
into Linux 2.6. See http://bmcsensors-26.sourceforge.net/ if you think
this is what you need. I can not help much on this myself.

-- 
Jean Delvare


From: ballen@gravity.phys.uwm.edu (Bruce Allen)
Date: Wed, 01 Mar 2006 16:14:20 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'd like to get lm_sensors support for a system with an HT1000 chip.
References are on http://www2.lm-sensors.nu/~lm78/newdrivers.html

-- I've rebuilt a stock 2.6.15.4 kernel using the HT1000 patch referenced
    on the newdrivers page:
    http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-piix4-add-ht1000-support.patch

-- I then built and installed sysfsutils-2.0.0

-- I then built and installed lm_sensors-2.10.0.

-- I loaded the i2c_piix4 module using modprobe.

-- I mounted sysfs on /sysfs

However sensors-detect does not find ANYTHING.  Not even eeprom!  Am I 
doing something stupid?

(Note: for kicks I also went into the lm_sensors source and 'hacked' the 
SERVERWORKS CSB6 0x0203 PCI-id to be 0x0205 both the sensors-detect script 
and in the i2c_piix4 code contained there. It didn't help.)

One other possibility is that because I have a BMC card plugged in to the 
motherboard (SuperMicro H8SSL-i) the BMC card is not allowing access to 
the devices from lm_sensors.

Cheers,
 	Bruce



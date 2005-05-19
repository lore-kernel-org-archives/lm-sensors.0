From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: Some oopsen
Message-Id: <20030928114738.37e71248.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030928084506.GB11794@woods.iki.fi>
In-Reply-To: <20030928084506.GB11794@woods.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> - Kernel vanilla 2.4.22
> - RSBAC 1.2.2
> - lm_sensors 2.6.5

Please update lm_sensors to 2.8.0. An installation guide is available
there:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/

(Basically, it provides a modified patch for i2c, to be applied to your
kernel sources. Then, you can install lm_sensors as usual).

> - sensors-detect (pressed enter to every prompt):
> (...)
> Next adapter: SMBus I801 adapter at 5000 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Can't open /dev/i2c[-/]2

You really should create this device file. Take a look at how devices 0
and 1 are named (depends wether you are using devfs or not) and use
mknod to create it (by default: char device, major 89, minor 2; see
prog/mkdev/mkdev.sh). Then, sensors-detect should be able to scan your
i801 chip and maybe find some other devices. 

If the problem persists with 2.8.0, we'll take a look at the oopses.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

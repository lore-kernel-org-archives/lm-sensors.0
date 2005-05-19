From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Cannot find via686a
Message-Id: <hFAv4K5S.1101371691.7938400.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041125010407.GA1267@eumel.yoo.local>
In-Reply-To: <20041125010407.GA1267@eumel.yoo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Torsten,

>I hope this is the best address for this kind of trouble report. If
>not I would be grateful for pointers to a better place.
>
>
>I want to use the sensors of my Abit KT7A-RAID motherboard, running
>Debian Sarge. For this, I started sensors-detect, which told me use
>the modules i2c-isa and via686a. I use a monolithic kernel, but I
>double-checked that both items are part of my 2.6.9 kernel.
>
>Alas, sensors can't find anything but the RAM:
>- - - Schnipp - - -
>yooden@eumel % sensors
>eeprom-i2c-1-51
>Adapter: SMBus Via Pro adapter at 5000
>Memory type:            SDR SDRAM DIMM
>Memory size (MB):       256
>
>eeprom-i2c-1-50
>Adapter: SMBus Via Pro adapter at 5000
>Memory type:            SDR SDRAM DIMM
>Memory size (MB):       256
>- - - Schnapp - - -
>
>
>Here are some kernel option which I think are important:
>- - - Schnipp - - -
>#
># I2C support
>#
>CONFIG_I2C=y
>CONFIG_I2C_CHARDEV=y
>
>#
># I2C Algorithms
>#
>CONFIG_I2C_ALGOBIT=y
># CONFIG_I2C_ALGOPCF is not set
># CONFIG_I2C_ALGOPCA is not set
>
>#
># I2C Hardware Bus support
>#
># CONFIG_I2C_ALI1535 is not set
># CONFIG_I2C_ALI1563 is not set
># CONFIG_I2C_ALI15X3 is not set
># CONFIG_I2C_AMD756 is not set
># CONFIG_I2C_AMD8111 is not set
># CONFIG_I2C_ELEKTOR is not set
># CONFIG_I2C_I801 is not set
># CONFIG_I2C_I810 is not set
>CONFIG_I2C_ISA=y
># CONFIG_I2C_NFORCE2 is not set
># CONFIG_I2C_PARPORT_LIGHT is not set
># CONFIG_I2C_PIIX4 is not set
># CONFIG_I2C_PROSAVAGE is not set
># CONFIG_I2C_SAVAGE4 is not set
># CONFIG_SCx200_ACB is not set
># CONFIG_I2C_SIS5595 is not set
># CONFIG_I2C_SIS630 is not set
># CONFIG_I2C_SIS96X is not set
># CONFIG_I2C_VIA is not set
>CONFIG_I2C_VIAPRO=y

The problem is here. i2c-viapro and via686a are mutually exclusive in
2.6. Remove i2c-viapro from your kernel if you want via686a to work

>(...)
>#
># Other I2C Chip support
>#
>CONFIG_SENSORS_EEPROM=y

Note that you may then disable this one too, since it'll be useless
without i2c-viapro.

The conflict is documented on our 2.6 kernel info page:
http://www2.lm-sensors.nu/~lm78/kernel26.html

I admit it would be better to actually fix the problem. Unfortunately I
don't know how to do that myself.

--
Jean Delvare

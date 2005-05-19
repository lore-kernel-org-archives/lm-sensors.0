From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <1078305199.4045a1af1c1c1@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Marc Rieffel <marc@paracel.com>:

> Looks like I don't need a new kernel after all,
> 
> make -f Makefile.p4b
> insmod p4b_smbus.o
> modprobe  i2c-core
> modprobe  i2c-i801
> modprobe  i2c-dev
> modprobe  i2c-proc
> modprobe adm1026
> 
> [root@gb0010 sensors]# cat /proc/bus/i2c
> i2c-1   smbus           SMBus I801 adapter at 0600             
> Non-I2C SMBus adapter

Great, although it's strange that you have no i2c-0 line...

> Still no luck, though,
> (...)
> Next adapter: SMBus I801 adapter at 0600 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):

This would suggest that there is absolutely nothing on this bus (which
could explain why it was disabled in the first place). What does
"i2cdetect 1" return?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

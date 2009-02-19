From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 19 Feb 2009 08:56:05 +0000
Subject: Re: [lm-sensors] w83793 driver for RHEL 5.2 x86_64
Message-Id: <499D1EA5.9050309@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <499C7EE4.5070200@assembler.cz>
In-Reply-To: <499C7EE4.5070200@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

maluyao napsal(a):
> This list ?
> 

yes its ok

> ls -l   /dev/i2c-*
> crw------- 1 root root 89, 0 Feb 19 13:08 /dev/i2c-0
> crw------- 1 root root 89, 1 Feb 19 13:08 /dev/i2c-1
> crw------- 1 root root 89, 2 Feb 19 13:08 /dev/i2c-2
> crw------- 1 root root 89, 3 Feb 19 13:08 /dev/i2c-3
> crw------- 1 root root 89, 4 Feb 19 13:08 /dev/i2c-4
> crw------- 1 root root 89, 5 Feb 19 13:08 /dev/i2c-5
> crw------- 1 root root 89, 6 Feb 19 13:08 /dev/i2c-6
> crw------- 1 root root 89, 7 Feb 19 13:08 /dev/i2c-7
> 
> dmesg |tail -n 1
> w83793 0-002f: set bank to 0 failed, fall back to bank 2, read reg 0x57 error

huh intressting message,

> 
> i2cdump 0 0x2f
> 
> No size specified (using byte-data access)
> Error: Could not set address to 0x2f: Device or resource busy

you need to unload the w83793
module (rmmod w83793)

Also please try to poweroff whole machine, unplug the power cord and run the 
i2c dump again.(The I2C bus is powered on even if the machine is off)
Ofcourse without driver loaded.

 From now it seems there is something wrong with the i2c bus.

Rudolf




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

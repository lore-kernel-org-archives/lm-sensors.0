From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 31 Mar 2006 11:15:21 +0000
Subject: [lm-sensors] Problems with i2c_i801
Message-Id: <20060331131521.24589bce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1143796746.10346.10.camel@cressida.cert>
In-Reply-To: <1143796746.10346.10.camel@cressida.cert>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

> > Where do the "sensors" program come from? Debian package?
> > Hand-compiled? Which version ("sensors -v")?
> 
> The Debian package
> 
> cressida:/home/james# sensors -v
> sensors version 2.10.0 with libsensors version 2.10.0

OK. Can you make sure that libsensors was compiled with sysfs support?
"ldd /usr/lib/libsensors.so" should have one line for libsysfs.

> Next adapter: SMBus I801 adapter at e8a0
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x30
> Client found at address 0x32
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Client at address 0x50 can not be probed - unload all client drivers
> first!
> Client at address 0x52 can not be probed - unload all client drivers
> first!
> Client found at address 0x69

No I2C/SMBus hardware monitoring chip...

> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (0x7601)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0x7601)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0x7601)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87591 Super IO'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC87371 Super IO'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC97371 Super IO'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC8739x Super IO'
>   Failed! (0x76)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0x76)
> Probing for `Nat. Semi. PCPC87427 Super IO'
>   Failed! (0x76)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0x76)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0x76)
> Probing for `SMSC LPC47B397-NC Super IO'
>   Failed! (0x76)
> Probing for `SMSC SCH5307-NS Super IO'
>   Failed! (0x76)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (skipping family)

You have a Super-I/O chip (a.k.a. LPC chip) we don't know about. Given
the output above, this could be a chip made by ITE, National
Semiconductor or SMSC. Can you find some documentation about your board
and/or open the case and locate that chip? Typically they are
rectangular, with 128 pins, and measure about 20 mm by 12 mm. Sometimes
these chips have hardware monitoring functionalities.

Does the BIOS of your system display any hardware monitoring
information? Is this system somehow advertise as having hardware
monitoring capabilities?

-- 
Jean Delvare


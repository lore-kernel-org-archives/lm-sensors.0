From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E4C89FB@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After modifying smsc47m1.c, sensors-detect didn't detect anything, but manually loading the smsc47m1 driver succeeded and gave me bogus fan speeds,

sensors
smsc47m1-isa-0800
Adapter: ISA adapter
fan1:       -1 RPM  (min = 2997 RPM, div = 2)
fan2:       -1 RPM  (min = 2997 RPM, div = 2)


ls /proc/sys/dev/sensors/smsc47m1-isa-0800/
alarms  fan1  fan2  fan_div  pwm1  pwm2

[root@gb0010 sensors]# cat /proc/sys/dev/sensors/smsc47m1-isa-0800/*
0
2997 -1
2997 -1
2 2
0 0
0 0

I must have sent you the i2c info before I had loaded one of the modules.  I can see both i2c-0 and i2c-1:

[root@gb0010 sensors]# cat /proc/bus/i2c
i2c-0   smbus           SMBus I801 adapter at 0600              Non-I2C SMBus adapter
i2c-1   dummy           ISA main adapter                        ISA bus algorithm

What do you think is preventing us from accessing the adm1026 chip?

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Wednesday, March 03, 2004 11:52 AM
> To: Marc Rieffel
> Cc: LM Sensors
> Subject: Re: lm_sensors on Itanium
> 
> 
> > With that change, I found the SMSC chip but no sensors.
> 
> This at least means that, if nothing else, you may be able to monitor
> your fans with that SMSC chip. The smsc47m1 driver wouldn't 
> load because
> it doesn't recognize the device ID as one it handles. I took a quick
> look at the 47B27x datasheet and it _seems_ to be compatible with the
> 47M1xx. Same logical device, same registers. If there are subtle
> differences, I could have missed them. If you want to take 
> your chance,
> edit smsc47m1.c, edit SMSC_DEVID_MATCH so that it likes your ID (0x51)
> and try using it.
> 
> > Neither i2c bus shows anything.
> 
> > [root@gb0010 sensors]# cat /proc/bus/i2c
> > i2c-0   dummy           ISA main adapter                        ISA
> > bus algorithm
> > 
> > [root@gb0010 sensors]# lm_sensors-2.8.4/prog/detect/i2cdetect 0
> > Error: Can't use SMBus Quick Write command on this bus (ISA bus?)
> > 
> > [root@gb0010 sensors]# lm_sensors-2.8.4/prog/detect/i2cdetect 1
> >   WARNING! This program can confuse your I2C bus, cause 
> data loss and
> >   worse! I will probe file /dev/i2c-1
> >   You have five seconds to reconsider and press CTRL-C!
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 
> That still surprises me much. How can i2c-1 exist and not be listed in
> /proc/bus/i2c? Very strange.
> 
> The SMBus way looks like a dead end anyway. I fear that we won't
> possibly offer you anything but fan monitoring with the SMSC chip.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 

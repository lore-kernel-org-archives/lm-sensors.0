From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 17:34:44 +0000
Subject: [lm-sensors] ADT7475
Message-Id: <20060902193444.a259efdb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juergen,

> it seems that the ADT7475 is compatible with an ADT7463, so i have tried to 
> use the lm85 driver. (The ADT7475 is missing the Vid Inputs.)

How did you figure out? I guess you mean the "vin inputs"? VID inputs
are something different. Oh well, they are also missing, anyway.

> My first attempd was to force the ADT7463 with
> 
> modprobe lm85 force_adt7463:0,0x2e
> 
> but this fails with
> ==> FATAL: Error inserting 
> lm85 /lib/modules/2.6.16.21-0.13-smp/kernel/drivers/hwmon/lm85.ko): Unknown 
> symbol in module, or unknown parameter (see dmesg)
> ==

Replace ":" with "=", and it should work better, except that according
to the output below, the proper address is 1,0x2e rather than 0,0x2e.

> 
> After that i have added the verstep to lm85.c
> 
> #define LM85_VERSTEP_ADT7475            0x69
> 
> and changed inside lm85_detect ...
> 
>   } else if( company = LM85_COMPANY_ANALOG_DEV
>                     && (verstep = LM85_VERSTEP_ADT7463
>                          || verstep = LM85_VERSTEP_ADT7463C
>                          || verstep = LM85_VERSTEP_ADT7475) ) {
>                         kind = adt7463 ;
> 
> now sensors give me the following infos:
> 
> snip=======> adt7463-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 1c40
> 
> V1.5:      +0.000 V  (min =  +0.00 V, max =  +3.32 V)
> VCore:     +0.000 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
> V3.3:      +3.395 V  (min =  +0.00 V, max =  +4.38 V)
> V5:       +0.000 V  (min =  +0.00 V, max =  +6.64 V)
> V12:      +0.000 V  (min =  +0.00 V, max = +15.94 V)
> CPU_Fan:   2019 RPM  (min =    0 RPM)
> fan2:      1420 RPM  (min =    0 RPM)
> fan3:      1889 RPM  (min =    0 RPM)
> fan4:         0 RPM  (min =    0 RPM)
> CPU Temp:  +0.25?C  (low  =    +1?C, high =    -1?C)     ALARM FAULT
> Board Temp:
>           +87.00?C  (low  =    +1?C, high =    -1?C)
> Remote Temp:
>            +0.00?C  (low  =    +1?C, high =    -1?C)     ALARM FAULT
> CPU_PWM:     0
> Fan2_PWM:    0
> Fan3_PWM:    0
> vid:      +0.000 V  (VRM Version 2.4)
> 
> snap=========> 
> What do you think about this ?

Looks good. I presume in2 is Vcc. The chip can also monitor one
external voltage but I guess it's not wired here (the IT8716F is used
to monitor Vcore.)

Do the fan speeds reported here match the ones displayed by your BIOS?
Can you try setting limits and checking whether alarms trigger as they
should?

The temp2 value is rather frightening... It is supposed to be the
chip's own temperature. It looks like the chip supports different modes,
include an "ADT7463 compatibility mode", and I guess your chip is not
in this mode, thus the weird reading. The external temperatures are
obviously not wired.

Now the question is, do we want to add support for the ADT7475 chip to
the lm85 driver? That's a recurring question, each time several chips
are compatible but still somewhat different.

In this case, the lm85 driver already supports 6 different chips
(although there was no reason to differenciate between the B and C
revisions as far as I can see) and we must beware of not increasing the
complexity of our drivers beyond reason. I'm not too sure what to do.
Maybe we can try adding support to the lm85 driver, and if it turns up
adding too much complexity, do a separate driver.

One element which may help us decide is whether the ADT7475 itself is
compatible with other chips. If it is, making a new driver for the
ADT7475 and the compatible chips would make sense. Can you make some
research?

-- 
Jean Delvare


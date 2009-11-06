From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Nov 2009 12:46:06 +0000
Subject: Re: [lm-sensors] lm sensors help
Message-Id: <20091106134606.5ddc1541@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <EDE287309C3D8141BC2A1DB7D9F8925D01C2D683EC@ESGSCCMS0002.eapac.ericsson.se>
In-Reply-To: <EDE287309C3D8141BC2A1DB7D9F8925D01C2D683EC@ESGSCCMS0002.eapac.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Shao,

On Tue, 3 Nov 2009 17:02:42 +0800, Rim Shao wrote:
> I use the sensors to collect the hardware information(fan speed/cpu temperature/voltage) on HP workstation FF825AV with SUSE Linux 10

Which version of "SUSE Linux 10" are you using exactly? Except for SLE
products, they are all unmaintained by now and I wouldn't recommend
using them any longer.

> installed, and I installed lm_sensors-3.0.2-1 and i2c-tools-3.0.2 package to my system. Then I executed the 'sensors' on the shell console and got the errors below.
> 
> ===============
> linux-ipworks:/mnt # sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> ===============
> 
> 
> also I type the sensors-detect to detect which sensor chip in my hardware. But I was told that there is no chips found, and I confirm with HP service support that this workstation surely have sensors embeded on the motherboard.

Would they tell you which chip is used for the hardware monitoring?
This would help us for sure.

> I posted the output of the command below. can you please help to find little clew ? your valuable information are appreciated!
> 
> 
> ===============
> linux-ipworks:/mnt # sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> (...)

This is very old, an definitely not from lm-sensors 3.0.2 which you
wrote you were using. Please double-check which version of the
"sensors" package you have installed.

Even better would be to try the latest version of the sensors-detect
script:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

(Our server seems to be very slow today, I hope you still manage to
download that file.)

> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (0x8c01)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0x8c01)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0x8c01)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87591 Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87371 Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC97371 Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC8739x Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PCPC87427 Super IO'
>   Failed! (0x8c)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0x8c)
> Probing for `SMSC LPC47B397-NC Super IO'
>   Failed! (0x8c)
> Probing for `SMSC SCH5307-NS Super IO'
>   Failed! (0x8c)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (skipping family)

Could be an SMSC SCH5317, hopefully a more recent version of
sensors-detect will confirm. We have partial support for this chip,
since kernel 2.6.25. Which kernel are you running?

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

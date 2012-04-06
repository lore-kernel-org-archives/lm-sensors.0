From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Fri, 06 Apr 2012 11:36:22 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016cJVhGgug0prZYSxxDNZ4APVpLwhgR0-7A=7CPbMPjjJg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Note the XX in the dump, which means an error occurred on the bus.
> Please check your kernel logs to see if there is an error message
> corresponding to this failure. If the I2C bus is unreliable, this could
> explain in part the trouble you had.

I read /var/log/dmesg.log and kern.log but I could not see an error or
warning related to anything or I do not have the capability to see.

> Comparing the original EDID with your tampered copy shows 6 bytes that
> are now 0xff instead of the value they used to hold:
>
> 0x2b: 0x01 -> 0xff
> 0x2e: 0x01 -> 0xff
> 0x2f: 0x01 -> 0xff
> 0x3b: 0x20 -> 0xff
> 0x3f: 0x30 -> 0xff
> 0x78: 0x33 -> 0xff
>
> FWIW, this doesn't correspond to a specific pattern for sensors-detect,
> which accesses the following offsets for probing this specific address:
> 0x00-0x07 and 0x3d-0x3f. So I still have no idea what happened and why.

Maybe, this is a hardware problem and is a coincidence so that the
time I use sensors-detect, the screen is "broken".

> Assuming your EDID EEPROM is writable, the following commands (as root)
> should restore its original state:
>
> # rmmod eeprom
> # i2cset -y 2 0x50 0x2b 0x01 b
> # i2cset -y 2 0x50 0x2e 0x01 b
> # i2cset -y 2 0x50 0x2f 0x01 b
> # i2cset -y 2 0x50 0x3b 0x20 b
> # i2cset -y 2 0x50 0x3f 0x30 b
> # i2cset -y 2 0x50 0x78 0x33 b
>
> You can check with i2cdump afterward. I'd even check after fixing the
> first byte, as there is no point in going on if the first write failed

Those commands worked without any error, I checked with i2cdump after
first and last command. Rebooted but it is still using 1280x1023.

I tried "radeon.modeset=0" parameter in grub and looked at
/var/log/Xorg.0.log, it shows that

II) RADEON(0): Panel Size from BIOS: 1280x1023
[    16.704] (II) RADEON(0): BIOS provided dividers will be used.
(WW) RADEON(0): LVDS Info:
XRes: 1280, YRes: 1023, DotClock: 68940
HBlank: 128, HOverPlus: 16, HSyncWidth: 248
VBlank: 16, VOverPlus: 1, VSyncWidth: 3

and with radeon enabled

[   14.238369] [drm] Panel Size 1280x1023
16.560] (II) RADEON(0): Output LVDS using initial mode 1280x1023

If I use xrandr --outpur LVDS --mode "try", /var/log/Xorg.0.log says

[  1644.860] (II) RADEON(0): Allocate new frame buffer 1280x800 stride 1280
[  1644.860] (II) RADEON(0): VRAM usage limit set to 50547K

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: 'Use the ddcmon and/or decode-edid.pl scripts' message
Message-Id: <CP7xb7De.1114510906.9855130.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <a8007ab4050425164642962763@mail.gmail.com>
In-Reply-To: <a8007ab4050425164642962763@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello rouble,

> Now, when I follow all the instructions, and reboot my box, and run
> sensors I get:
>
> ~ #1004 > sensors
> pc87360-isa-0820
> Adapter: ISA adapter
> fan1: 0 RPM (min = 952 RPM, div = 8) OVERFLOW
> fan2: 0 RPM (min = 952 RPM, div = 8) OVERFLOW

This is a 2-channel fan speed monitoring function embedded in your
Super-I/O chip. Unfortunately, it doesn't seem that any fan is actually
connected to it, thus the zero readings and overflow flags.

BTW, you pointed out a bug in the driver (the min limit being arbitrarily
set to 952 RPM, while it was most likely disabled in the first place). I
will have to fix that.

> what does it mean by 'Use the ddcmon and/or decode-edid.pl scripts' ?

There are a few helper scripts that come with lm_sensors to decode
EEPROMs better than "sensors" does. Two of these are aimed at EDID
EEPROMs, which are frequently found in monitors and accessed through an
I2C-compatible bus named DDC. The scripts are in prog/eeprom in the
source tree, and should have been installed together with "sensors"
itself. Just give a try to the one named "ddcmon" if you want the
details of your monitor capabilities.

> and what am I doing wrong here. Any assistance is appreciated.

I don't think you're doing anything wrong. Your system is simply short
of (known) hardware monitoring devices.

--
Jean Delvare

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: Asus P4C800-E Deluxe/Winbond W83627THF issue
Message-Id: <20050202233112.5781be19.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502022021.06992.wik@blueyonder.co.uk>
In-Reply-To: <200502022021.06992.wik@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rik,

> I'm something of a noob to Linux (only two years...) so please
> bear with me. :-)

Not exactly my definition of the newbie, but nevermind ;)

> I'm running Suse 9.2 Pro with a 2.6.8 kernel (2.6.8-24.11-smp to be
> precise)  and whilst I've made /some/ progress with getting sensors to
> work, I seem to  be getting less positive results than I did on my
> previous 2.4-based build.
> 
> I'm getting it to see the sensor and it's giving some interesting
> figures  despite tweaking and twiddling sensors.conf until I've gone
> cross-eyed.
> 
> I /think/ that CPU temp figure is a tad low and suspect it to be the
> mobo  temp.
> 
> I've tried issuing the "force_w83627thf:" parm when loading the
> module,  however, I'm unsure of the array parms that should follow.

FYI, this parameter is completely ignored by the w83627hf driver, both
for 2.4 and 2.6 kernels. Cleaning this up is part of my todo list...
among a dozen dozen other things, most of which have higher priorities
ATM.

Anyway you clearly don't need this, the w83627thf is always correctly
detected, and so is yours.

> Also, despite setting the vid parm to 9.0, 9.1 and 10.0, I still can't
> get rid  of the error...

Which version of "libsensors" (and lm_sensors) is this? "sensors -v" and
"ls -l /usr/lib/libsensor* /usr/local/lib/libsensor*" should tell. I
think that the error on VID is caused by an old version of the library.
For a 2.6.8 kernel, I think I remember you need at least lm_sensor 2.8.6
(libsensors 3.0.4). If Suse backported some patches to their kernel, you
might even need 2.8.8 (libsensors 3.0.6).

> M/B Temp:   +125?C  (high =    +0?C, hyst =    +0?C)   sensor > PII/Celeron  diode
> CPU Temp:  +26.0?C  (high =   +80?C, hyst =   +75?C)   sensor > PII/Celeron  diode
> temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor > thermistor

I agree that the CPU temperature seems to be a bit low - however the MBM
site confirms that CPU temp is temp2 in diode mode for this motherboard,
so it would be correct. For motherboard you should set the sensor type
to thermistor, and hopefully you would get a decent reading. You can try
to switch temp3 to diode just in case, but most likely there's no third
sensor so you can just add "ignore temp3" to your configuration file.

If the motherboard BIOS displays some hardware monitoring information,
comparing with what "sensors" reports is usually a good way to get
things configured properly.

Hope that helps,
-- 
Jean Delvare

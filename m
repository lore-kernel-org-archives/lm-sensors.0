From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: I2C crash - ADM1021
Message-Id: <20030918230702.21b02c97.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi, and thanks for all your work on lm sensors and i2c!
> I am running Mandrake Linux 9.1 with a lot of Cooker additions. 
> Mandrake's Kernel 2.4.21-0.13 with Win4Lin hook.

What's that Win4Lin thing?

> My system is a homemade one with a Soyo SY-Kt400 (Dragon Ultra Black)
> with Phoenix Bios updated as of April 2003 with an AMD XP 2000 CPU.
> 
> I compiled and successfully installed the CVS versions of I2C and
> lm_sensors2.
> 
> After performing sensors-detect, On MY system, the loading of the
> driver ADM1021 causes a catostrophic system failure which requires a
> complete restore of the hard drive partition that Linux is on.  In the
> sensors-detect messages, it DOES say that this driver can cause
> problems.

Well, I am really sorry for you. We are doing our best to prevent these
problems, but it turns out that the I2C/SMBus operations are risky on a
few systems, and there's almost nothing we can do against that, apart
from plain stopping the project.

> After some thinking and many system restores, I removed the ADM1021
> driver modprobe line in rc.local, and the corresponding line in
> modules.conf and the sensors program seems to run fine.  I get both
> the die temperature of the CPU accurately and the system temperature
> also(which is all I am interested in).
> 
> I am attaching 3 files for you to review.
> 1) sensors-output.txt which shows my system info -- alarms and all
> (which I ignore) from the sensors program
> 2) sensors-detect-output.txt which shows your program's analysis of my
> system
> 3) i2cdetect-i2cdump-output.txt which shows the I2C dumps of devices
> uncovered by your program.
> 
> Of course, there is no I2C support in my kernel, and as I mentioned,
> the sensors output runs rine.
> 
> Best wishes, and thank you for your efforts.  If I can help clarify
> anything, or provide you with additional details, please let me know!

Thanks a lot for taking the time to report (and not even complain about
what happened to you).

There are a few comments and questions that come to me after reading the
files you attached.

Although I don't know which chipset is at 0x18, I remember that we had a
similar dump reported a few days ago.

The chip at 0x4c is doubtlessly a LM90, and is detected as such (BTW,
note that you need the latest CVS for it to refresh correctly).

No idea what could be at 0x4e, but it is neither a LM75 nor a ADM1021
clone, sensors-detect is obviously wrong here. So you can remove lm75
from your module list.

At 0x52 you have a SPD EEPROM, also detected OK by sensors-detect.

At 0x69, this must be a clock ship that we usually advise not to play
with ;)

Now, for the adm1021 problems, I'm puzzled. The option line in
/etc/sensors.conf, as suggested by sensors-detect, prevents the driver
from using any of the three addresses at which you have chipsets (0x18,
0x4c, 0x4e) so loading it shouldn't have had any effect. But, since it
was crashing your system, it must have been doing something. What, that
I can't understand. Do you have any log that survived the crashes so
that we could try understanding what happened?

Again, thanks for reporting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

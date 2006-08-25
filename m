From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 25 Aug 2006 21:34:54 +0000
Subject: [lm-sensors] it8716 under 2.6
Message-Id: <20060825233454.ab32b1da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060825084257.556030b7.khali@linux-fr.org>
In-Reply-To: <20060825084257.556030b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo J?rgen,

> I gues the expected speed for the fans are:
> CPU-Fan:
> Arctic Cooling Alpine 64 : 
> expected speed		:2000 RPM
> according to sensors output 	:4179 RPM
> Bios output 			:2096 RPM
> 
> CHA_FAN 1 is an  
> Revoltec AirGuard 120mm, 23.94 dBA 
> expected speed		:1200 RPM
> according to sensors output 	:2494 RPM 
> Bios output 			:1256 RPM
> 
> PWR_FAN:
> Enermax Liberty EL500AWT 120mm Fan
> expected speed		:??? RPM
> according to sensors output 	:903 RPM / 
> Bios output 			:1256 RPM

Copy-n-paste typo for this last value?

> i would beleive the BIOS values....

Yep everyone seems to agree - I've updated my patch:
http://jdelvare.pck.nerim.net/sensors/hwmon-it8716f-it8718f-v3-2.6.18.patch
Fan readings for fan1 and fan2 should be OK now - not sure about fan3.
Can you test and report?

> > Do the voltages match what the BIOS says if you use the default
> > configuration file?
> >
> Voltages:
> 		Bios		Sensors with default config
> Vcore		1,31V		1,01V (maybe the BIOS value is so high after power up)

Yes, your CPU can change its Vcore depending on frequency.

> 3,3V		3,41V		3,22V (i think it is the voltage called VDDR)

Then just change the label to "+3.3V" in sensors.conf.

> 5V		5,13V		4,78V
> 12V		12,3V		11,46V
> CPU-Temp	26?		24?
> MB-Temp	28?		31?
> 
> I think, it doesn't look too bad. Should it be better ?

Hmm, all your voltages are lower in sensors than in the BIOS. We just
had a similar report, however I also had reports where the voltages
match so I think the driver works. I just can't explain this difference
on some Asus boards.

For temperatures it is OK, BIOS is usually in a busy loop so slightly
hotter than Linux at idle.

> Sure here is the complete output of "sensors detect"
> ====================> sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> 
> This program will help you determine which I2C/SMBus modules you need to
> load to use lm_sensors most effectively. You need to have i2c and
> lm_sensors installed before running this program.
> Also, you need to be `root', or at least have access to the /dev/i2c-*
> files, for most things.
> If you have patched your kernel and have some drivers built in, you can
> safely answer NO if asked to load some modules. In this case, things may
> seem a bit confusing, but they will still work.
> 
> It is generally safe and recommended to accept the default answers to all
> questions, unless you know what you're doing.
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): yes
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.

Ah, hardware is too recent for lm_sensors 2.10.0's sensors-detect. Can
you please pick SVN's version and try again?

http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

Thanks,
-- 
Jean Delvare


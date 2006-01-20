From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 20 Jan 2006 03:53:00 +0000
Subject: [lm-sensors] Asus a8v problems.
Message-Id: <20060120035300.GA8312@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <43CE945F.8020105@imperialnet.org>
In-Reply-To: <43CE945F.8020105@imperialnet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Patric:

Please reply to the list also.

> >* Patric <pakar at imperialnet.org> [2006-01-18 20:17:51 +0100]:
> >>I seem to have some problems with lm-sensors here.
> >>First, it seems like in some revision of lm-sensors i lost the ability 
> >>to see the RAM that was installed in the system (see the i2cdump later). 
> >>I know this worked before, but i'm not shure what version of lm-sensors 
> >>it was ten.

> Mark M. Hoffman wrote:
> >That's a feature, not a bug. ;) Seriously though, we've decided that
> >memory/SPD display was useful neither for sensors(1) nor libsensors(3).
> >You can get the same info (and much more) using the perl script 
> >decode-dimms.pl which is in the lm-sensors package also.
> >
> >I see now, this is not mentioned in the CHANGES file.  I'll fix that.

* Patric <pakar at imperialnet.org> [2006-01-19 07:05:02 +0100]:
> Ah, that's why i was a bit confused. =)
> The decode-dimms.pl works even better..

I'm glad you like it.

> >>The problem that i'm having is that i dont seem to be able to control 
> >>fan3. Speeds and everything is correct, but if i just do an echo 0 >pwm3 
> >>the fan still does not stop. fan1 and 2 (and pwm1 and 2) works 
> >>perfectly. Any hints of what to look at would be a great help, or if you 
> >>know that there is some problems like this. (did not find any matching 
> >>entrys in the bug-tracker)
> >
> >
> >>[...]
> >
> >
> >>Probing for `Winbond W83627THF Super IO Sensors'
> >>  Success... found at address 0x0290
> >
> >
> >Using the command 'echo 0 > pwm3' should depend on the kernel driver only.
> >What kernel version are you using?  What version were you using the last
> >time that worked?  Also, can you please send the output from sensors(1) ?
> >
> >
> 
> Well, it seems never to have worked, but i just had to install a new fan 
> that is much too loud at max speed.
> 
> The kernels that i was running at the time i wrote my last mail i was 
> running 2.6.15 with a few patches and now i have upgraded to the latest 
> mm-kernel 2.6.16-mm1-rc1. And i have been running 2.6.13 and 2.6.14 
> before that.
> If there are there any updates for the w83627hf driver that has not yet 
> been introduced into the mm-kernel i'm happy to give those a try.
> 
> $ sensors
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.26 V  (min =  +0.64 V, max =  +0.70 V)       ALARM
> +12V:     +11.43 V  (min = +10.82 V, max = +13.19 V)
> +3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +5.12 V  (min =  +4.75 V, max =  +5.25 V)
> -12V:      +6.06 V  (min = -10.80 V, max = -13.18 V)       ALARM
> V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +2.78 V  (min =  +2.40 V, max =  +3.60 V)
> Case Fan:    0 RPM  (min =  998 RPM, div = 8)              ALARM
> CPU Fan:  1344 RPM  (min = 1328 RPM, div = 4)
> Top Fan:  2636 RPM  (min = 1328 RPM, div = 4)
> M/B Temp:    +25 C  (high =   +50 C, hyst =   +32 C)   sensor = 
> thermistor
> CPU Temp:  +29.5 C  (high =   +52 C, hyst =   +47 C)   sensor = 
> thermistor
> Pwr Temp:  +17.0 C  (high =   +80 C, hyst =   +75 C)   sensor = 
> thermistor
> vid:      +0.675 V  (VRM Version 2.4)
> alarms:
> beep_enable:
>           Sound alarm enabled
> 
> "Case Fan" in this case should be 0 due too the low temp, but the 
> problematic fan is the one called "Top Fan".
> 
> fan3 looks ok here, and the speed changes slightly also so it does not 
> just read a static value.

Some boards have fan headers that are wired to +12V instead of using
the hwmon chip PWM output, even though the speed detection signal is
there.  One of my boards is like that (Asus P4C800E-Deluxe); probably
yours is too.  Sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 16:41:51 +0000
Subject: Re: [lm-sensors] "echo 0 > pwm2" does NOT stop fan
Message-Id: <20090114174151.2646b14a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <676459746@web.de>
In-Reply-To: <676459746@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David, Jens,

On Sun, 11 Jan 2009 22:59:33 -0700, David Hubbard wrote:
> Hi Jens,
> 
> On Sun, Jan 11, 2009 at 1:44 PM, Jens Gottstein <ruena@web.de> wrote:
> > Hi there,
> >
> > since many years I use fancontrol on many systems - its a great software - thanks a lot.
> >
> > On my new system it does not stop my CPU-fan - just slows the fan down.
> >
> > I have a ASUS p5k-v with a w83627ehf, Ubuntu 8.10 (and 8.04) with a intel boxed fan (4-pins on the cable to the fan),
> >
> > uname -a :
> >  Linux 2.6.27-9-generic SMP Thu Nov 20 21:57:00 UTC 2008 i686 GNU/Linux
> >
> > I did:
> > cd /sys/devices/platform/w83627ehf.656/
> > echo 255 > pwm2
> > The fan is at full speed (cat fan2_input yields 2556)
> >
> > echo 0 > pwm2
> > The fan does NOT stop, it just goes slow (cat fan2_input yields 1010)
> >
> > pwmconfig and fancontrol have the same problem.
> >
> > How can I stop the fan completely?

FWIW, I observe the same on my Intel D865GSA, same monitoring chip
(Winbond W83627EHF.)

> > I also tried the "Thermal Cruise mode", but this does not stop the fan, too.
> >
> >
> > The content of the files in  /sys/devices/platform/w83627ehf.656/
> >
> > cat pwm2: 0
> > cat pwm2_enable: 1
> > cat pwm2_min_output: 1
> > cat pwm2_mode: 1
> > cat pwm2_stop_time: 1000
> > cat pwm2_target: 60000
> > cat pwm2_tolerance: 10000
> >
> > I am looking forward to your answers
> >
> > Thanks in advance
> >
> > ruena
> 
> You probably can't stop the fan completely. Can the BIOS stop the fan
> completely? With a 4 pin fan, the fan does not depend on the output of
> the sensors chip and can have a fixed minimum speed.

What does this have to do with 4-pin fans? This is indeed what I have,
but I can't see the relation. I thought that the 4th pin was simply
there to get proper speeds reported even when low PWM duty cycles were
used. If there more to it than that?

This is the only 4-pin fan I have and, as far as I know, the only
mainboard I have that support a 4-pin fan, so I can't do that many
tests.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

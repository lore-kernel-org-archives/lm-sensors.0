From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 16:30:02 +0000
Subject: Re: [lm-sensors] pwmconfig and fancontrol don't work in ubuntu 10.11 archlinux kernel 3.2
Message-Id: <1328718602.2261.313.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F27026A.4080904@gmail.com>
In-Reply-To: <4F27026A.4080904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-31 at 06:59 -0500, David Kremer wrote:
> > There is a bug in the upstream driver affecting the number of fans
> > detected for NCT6776F. You can try a possible fix by loading and
> > installing the driver from
> > https://github.com/groeck/w83627ehf/archives/testing.
> >
> > No idea if that helps, though. The bug has always been there, so I have
> > no explanation why it might have worked with archlinux 3.0 LTS.
> >
> > Guenter
> Hi, thank you for your answer. I am actually logged into archlinux with 
> "linux LTS 3.0.17". I suspect that maybe the bug you outlined has been 
> corrected in this branch. I stay at you disposal if ever you want to 
> investigate this furthermore.
> 
> However, there is some kind of bug with the CPUTIN and the AUXTIN which 
> I don't understand. Why the CPUTIN from the nct interface is so high 
> (around 75 Celsius degrees) since the coretemp interface (which I 
> believe is working) gives me 35 Celsius degree for the CPU temp ?

David,

I modified the driver in above repository (the testing branch) to let
you set the temperature sensor type. Maybe you can load it into your
system and configure the CPU sensor as "diode(1)". It would be
interesting to see if that makes a difference in the reported
temperature.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

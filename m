From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 31 Jan 2012 14:50:11 +0000
Subject: Re: [lm-sensors] pwmconfig and fancontrol don't work in ubuntu 10.11 archlinux kernel 3.2
Message-Id: <20120131145011.GA8386@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F27026A.4080904@gmail.com>
In-Reply-To: <4F27026A.4080904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 31, 2012 at 06:59:57AM -0500, David Kremer wrote:
> 
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
Would be great if the archlinux folks would submit their patches upstream,
if there are any.

> However, there is some kind of bug with the CPUTIN and the AUXTIN which 
> I don't understand. Why the CPUTIN from the nct interface is so high 
> (around 75 Celsius degrees) since the coretemp interface (which I 
> believe is working) gives me 35 Celsius degree for the CPU temp ?
> 
I have seen that with a number of boards. So far I have no idea what is going on.
My best guess is that the pins are not really connected, and that PECI Agent 0
is the real CPU temperature. Another guess is that the sensor type is not
configured correctly. I might create a test version of the driver where
it can be set to check that possibility.

> Guenter, I am going to test your driver under various configuration, and 
> see if changes happen. Then I will report you new problems I detect.
> 
Thanks!

Guenter

> David
> 

> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +34.0??C  (high = +82.0??C, crit = +102.0??C)
> Core 0:         +31.0??C  (high = +82.0??C, crit = +102.0??C)
> Core 1:         +32.0??C  (high = +82.0??C, crit = +102.0??C)
> 
> nct6776-isa-0290
> Adapter: ISA adapter
> Vcore:         +0.88 V  (min =  +0.00 V, max =  +1.74 V)
> in1:           +1.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> AVCC:          +3.39 V  (min =  +2.98 V, max =  +3.63 V)
> +3.3V:         +3.38 V  (min =  +2.98 V, max =  +3.63 V)
> in4:           +1.01 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:           +2.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 3VSB:          +3.39 V  (min =  +2.98 V, max =  +3.63 V)
> Vbat:          +3.26 V  (min =  +2.70 V, max =  +3.30 V)
> fan1:            0 RPM  (min =    0 RPM)  ALARM
> fan2:          275 RPM  (min =    0 RPM)  ALARM
> fan3:            0 RPM  (min =    0 RPM)  ALARM
> fan4:            0 RPM  (min =    0 RPM)  ALARM
> fan5:            0 RPM  (min =    0 RPM)  ALARM
> SYSTIN:        +26.0??C  (high =  +0.0??C, hyst =  +0.0??C)  ALARM  sensor = thermistor
> CPUTIN:        +84.5??C  (high = +81.0??C, hyst = +76.0??C)  ALARM  sensor = thermistor
> AUXTIN:        +74.5??C  (high = +80.0??C, hyst = +75.0??C)  sensor = thermistor
> PECI Agent 0:  +33.5??C  
> cpu0_vid:     +2.050 V
> 

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


-- 
Guenter Roeck
Distinguished Engineer
PDU IP Systems

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

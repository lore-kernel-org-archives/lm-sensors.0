From: upgrdman@mindspring.com (Farrell Farahbod)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors program library problems (more info)
Message-Id: <1058846875.31848.2.camel@farrell.freemans.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058790834.16392.3.camel@farrell.freemans.org>
In-Reply-To: <1058790834.16392.3.camel@farrell.freemans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ahh..thanks soo much for the clarification.

about my temp being 95F fir my cpu...well now its 96.8F but still...

when i got my new amd 2000+ cpu (1.67GHZ, 266FSB) it didnt come with a
heatsink/fan. so i bought one seperatly, and to be extra cautious, and
so if i upgrade later...i bought a heatsink/fan that is ment to work
with upto an amd 3000+ barton processor. (2.16ghz (2.??..16 i think)
400fsb).

so now its extra cool! :)

thanks,

farrell f.

On Mon, 2003-07-21 at 09:30, Jean Delvare wrote:
> > now "sensors" shows me this:
> > 
> > [root@farrell root]# sensors -f
> > w83697hf-isa-0290
> > Adapter: ISA adapter
> > Algorithm: ISA algorithm
> > VCore:     +1.60 V  (min =  +1.71 V, max =  +1.88 V)
> > +3.3V:     +3.29 V  (min =  +3.13 V, max =  +3.45 V)
> > +5V:       +4.91 V  (min =  +4.72 V, max =  +5.24 V)
> > +12V:     +12.01 V  (min = +10.79 V, max = +13.19 V)
> > -12V:     -12.29 V  (min = -13.21 V, max = -10.90 V)
> > -5V:       -5.20 V  (min =  -5.26 V, max =  -4.76 V)
> > V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
> > VBat:      +3.12 V  (min =  +2.40 V, max =  +3.60 V)
> > fan1:     6958 RPM  (min = 3000 RPM, div = 2)
> > fan2:     2766 RPM  (min = 3000 RPM, div = 2)
> > temp1:       +95?F  (limit = +140?F)                       sensor > > thermistor
> >           
> > temp2:     +94.1?F  (limit = +140?F, hysteresis = +122?F) sensor > > thermistor
> >          
> > alarms:
> > beep_enable:
> >           Sound alarm disabled
> 
> That's pretty good at first sight.
> 
> > if the min/max value it shows are what the voltage show be between...
> > it would seem my VCore and +3.3volt are a little wrong. both a little
> > too low. do you know if the difference is big enough to cause
> > problems?
> 
> +3.3V could hardly be better! VCore would need tweaking. Edit the
> /etc/sensors.conf file, look for the w83697hf section, uncomment the
> "set vrm" line and it should be better (after a "sensors -s" maybe). If
> it's still not OK, you can edit the "set in0_min" and "set in0_max"
> lines, just replace vid by what you know should be your CPU voltage
> (well, if you know).
> 
> > lastly, but also important, the temperatures. "+95?F" why the "?", is
> > that an estimate... does it need to be calibrated?
> 
> It's supposed to be the symbol of the degree. Works well for me, strange
> it doesn't for you. It's not part of the ASCII table, so maybe if you
> have a non-ISO-8859-1 charset in use, this could explain you can't see
> it.
> 
> 95 degres Farenheit is really low, you must have a great cooling system
> :) Mine is at 135.
> 
> > thanks again,
> 
> You're welcome.

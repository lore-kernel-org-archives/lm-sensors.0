From: stefan@ryo-ohkI.mine.nu (Stefan Andersson)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: Problems.
Message-Id: <006a01c35da6$920c2690$c44f5e51@cerebro>
List-Id: <lm-sensors.vger.kernel.org>
References: <005601c35d84$f18690a0$c44f5e51@cerebro>
In-Reply-To: <005601c35d84$f18690a0$c44f5e51@cerebro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi ....
Yes I've run "sensors -s" ..
                              -------------------- snapshop from asus.com -
start
      Chipset SIS645DX SIS962L

                              -------------------- snapshop from asus.com -
stop
There you have the chipset =)
And i have seen other readings from BIOS .. but not anywhere else..
And atleast that reading says 40C on the CPU ... Thankd goodness ;)
Thanks for your quick answer .. I'm going away over the weekend now.
But when i get back i'll try my very best at customnizing those
limits/values
Thanks again !

----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Stefan Andersson" <stefan@networksolutions.se>
Cc: <sensors@Stimpy.netroedge.com>
Sent: Friday, August 08, 2003 10:37
Subject: Re: Problems.


>
> > Hi.. I'm having trouble getting a fair reading ..
> > I have a ASUS P4S533-X
> >
> > sensors-detect tells me to use the sis-645 , it87 , i2c-isa modules
> > ...
> >
> > and then i get this reading:
>
> Preliminary question, did you run "sensors -s"?
>
> > VCore 1:   +1.55 V  (min =  +1.42 V, max =  +1.56 V)
> > VCore 2:   +1.66 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
>
> You may have to adjust the min and max values in /etc/sensors.conf (look
> for the it87-* section). The nominal value for VCore 1 & 2 depends on
> the CPU and we can't guess it. We use 1.5V and 2.5V because these are
> the most frequently seen values, but if your CPU uses different
> voltages, you have to adjust the configuration file to match them. VCore
> 1 seems to be OK here, but VCore 2 isn't, for sure.
>
> > +3.3V:     +6.04 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
>
> This is a known problem, and the fix is detailed in the config file. You
> may still have some problems after using the fix however.
>
> > +5V:       +4.99 V  (min =  +4.72 V, max =  +5.24 V)
> > VBat:      +3.23 V
>
> At least these ones are prefect :)
>
> > -12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
> > -5V:      -13.64 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
>
> There are alternate furmulae in the config file, please give them a try
> (don't forget to run "sensors -s" afterwards).
>
> > +12V:      +0.00 V  (min = +11.36 V, max = +12.60 V)   ALARM
> > Stdby:     +0.00 V  (min =  +4.72 V, max =  +5.24 V)   ALARM
>
> I'm really astonished (especially by the +12V). Do you have readings for
> these ones in your BIOS setup screen or other OS?
>
> This reminds me of something I read about the ADM1025/NE1619, but I'd
> need to read the datasheet for your chipset to confirm. Do you know
> which of the IT8705F, IT8712F or SiS950 you do actually have?
>
> > fan1:     2732 RPM  (min =    0 RPM, div = 2)
> > fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
> > fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
>
> I guess you simply have only one fan. Add "ignore fan2" and "ignore
> fan3" lines to your config file (section it87-* of course).
>
> > Temp1/MB:    +75?C  (min =  +20?C, max =  +40?C)
> > Temp2/CPU:   +86?C  (min =  +25?C, max =  +45?C)
> > Temp3:      +127?C  (min =  +25?C, max =  +45?C)
>
> I admit the readings are probably wrong. Try using the temp_type
> parameter (for more details, read doc/chips/it87), maybe it'll help.
>
>
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/

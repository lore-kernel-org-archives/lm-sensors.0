From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 May 2012 00:48:11 +0000
Subject: Re: [lm-sensors] missing fan RPMS
Message-Id: <20120514004811.GA13194@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAED541.7080201@lockie.ca>
In-Reply-To: <4FAED541.7080201@lockie.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 13, 2012 at 08:08:28PM -0400, James wrote:
[ ... ]

> > +3.3V:          +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> > in4:            +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> > in5:            +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> > 3VSB:           +3.46 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> > Vbat:           +3.36 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> > fan1:          1369 RPM  (min =    0 RPM)  ALARM
> > fan2:             0 RPM  (min =    0 RPM)  ALARM
> > fan3:             0 RPM  (min =    0 RPM)  ALARM
> > fan4:             0 RPM  (min =    0 RPM)  ALARM
> > fan5:             0 RPM  (min =    0 RPM)  ALARM
> > SYSTIN:         +36.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = thermistor
> > CPUTIN:         +35.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> > AUXTIN:          -2.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> > PCH_CHIP_TEMP:   +0.0 C  
> > PCH_CPU_TEMP:    +0.0 C  
> > PCH_MCH_TEMP:    +0.0 C  
> > cpu0_vid:      +0.000 V
> > intrusion0:    ALARM
> > intrusion1:    ALARM
> > 
> > It is labelled 'Chassis fan connector 1" by the motherboard manual.
> > The other is 'Chassis fan 3'
> > 
> > The difference is fan1 is 3 pin and fan3 is 4 pin.
> > I will try moving the 4 pin over so it is only using 3 pins.
> > 
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> > 
> 
> :-(
> Both fans connected but only one shows up.
> 
Yes, I think that is exactly the problem. Looks like the board uses a multiplexer
to connect multiple fans to the same fan sensor input. Which makes it all but impossible
for third parties (like Linux) to implement working fan control. Really annoying,
especially since the NCT6776F has really a lot of fan sensor inputs available.

At least some of the other boards from the same vendor have lots of fan connectors.
Did you try all of them ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

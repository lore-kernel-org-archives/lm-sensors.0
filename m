From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 13 May 2012 03:40:43 +0000
Subject: Re: [lm-sensors] missing fan RPMS
Message-Id: <20120513034043.GA9100@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAED541.7080201@lockie.ca>
In-Reply-To: <4FAED541.7080201@lockie.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 12, 2012 at 10:55:13PM -0400, James wrote:
[ ... ]
> > 
> Can I assume it is using the module I compiled because it has some data?
> Still no fan data
> nct6776-isa-0290
> Adapter: ISA adapter
> Vcore:          +0.97 V  (min =  +0.00 V, max =  +1.74 V)
> in1:            +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> AVCC:           +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> +3.3V:          +3.31 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in4:            +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> in5:            +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> 3VSB:           +3.44 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> Vbat:           +3.36 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> fan1:             0 RPM  (min =    0 RPM)  ALARM
> fan2:             0 RPM  (min =    0 RPM)  ALARM
> fan3:             0 RPM  (min =    0 RPM)  ALARM
> fan4:             0 RPM  (min =    0 RPM)  ALARM
> fan5:             0 RPM  (min =    0 RPM)  ALARM
> SYSTIN:         +37.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor = thermistor
> CPUTIN:         +37.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> AUXTIN:          -1.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> PCH_CHIP_TEMP:   +0.0 C  
> PCH_CPU_TEMP:    +0.0 C  
> PCH_MCH_TEMP:    +0.0 C  

Yes, because the above are only seen with the new driver.

Still, see my other e-mail - looks like AsRock is using a gpio pin based multiplexer
to connect fans to the chip. I looks like specific gpio pins must be enabled to let
you see fan speeds.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

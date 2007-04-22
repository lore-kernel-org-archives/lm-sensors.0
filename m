From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Apr 2007 10:45:00 +0000
Subject: Re: [lm-sensors] lmsensors in 2.6.16 on a Tyan 2882-D motherboard,
Message-Id: <20070422124500.38a1d274@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <44325498.8060805@corky.net>
In-Reply-To: <44325498.8060805@corky.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 19 Apr 2007 10:57:52 +0100, Just Marc wrote:
> Jean Delvare wrote:
> > On Wed, 18 Apr 2007 13:46:26 +0100, Just Marc wrote:
> >> box:~/lm_sensors-2.10.3# /usr/local/bin/sensors -v
> >> sensors version 2.10.3 with libsensors version 2.10.3
> >> box:~/lm_sensors-2.10.3# /usr/local/bin/sensors  
> >> w83627hf-isa-0290
> >> Adapter: ISA adapter
> >> CPU2 Volt: +1.42 V  (min =  +1.33 V, max =  +1.47 V)             
> >> CPU1 Volt: +1.44 V  (min =  +1.33 V, max =  +1.47 V)             
> >> 3.3V:      +3.30 V  (min =  +3.14 V, max =  +3.47 V)             
> >> DDR VTT:   +1.30 V  (min =  +2.85 V, max =  +3.47 V)       ALARM 
> >> DDR 2.5V:  +2.56 V  (min =  +0.34 V, max =  +0.80 V)       ALARM 
> >> CPU2 Fan: 3924 RPM  (min = 7670 RPM, div = 8)              ALARM 
> >> CPU1 Fan: 3443 RPM  (min = 1430 RPM, div = 8)                    
> >> Fan5:        0 RPM  (min =  730 RPM, div = 8)              ALARM 
> >> vid:      +1.400 V  (VRM Version 2.4)
> >> alarms:  
> >> beep_enable:
> >>           Sound alarm enabled
> >>     
> >
> > I don't see anything weird here. Just the limits of the two DDR
> > voltages and fans 1 and 3 need to be set to sensible values, and you're
> > done
> 
> I agree about the fan stuff.     As for the DDR voltage, since I used 
> the conf provided by Tyan and also tried the conf files found in other 
> places specifically for this motherboard, why should the DDR voltage 
> range be tweaked?

I pretty much doubt that your configuration file sets the min and max
limits of DDR 2.5V to +0.34 V and +0.80 V respectively. More likely,
the chip is powered up in that state. But given that you did not show
us your configuration file, I can't comment further on that. What I can
say is that 1.30 V for DDR VTT and 2.56 V for DDR are good values,
while the limits set for these voltages, assuming a correct labelling,
don't make any sense.

> Also, the BIOS is able to report RAM temperatures and a bit more info, 
> how can we extract this extra stuff using sensors?

We don't yet support RAM temperatures. As far as I remember, we don't
have enough documentation to write a driver for that.

As for "a bit more info", we don't support that either, and never
will ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

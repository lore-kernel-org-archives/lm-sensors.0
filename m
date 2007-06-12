From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jun 2007 16:25:47 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <20070612182547.591ed2fa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Mon, 11 Jun 2007 18:21:13 +0200, Ivo Manca wrote:
> in4:       +3.55 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> 
> after md5sum:
> [root@localhost ivo]# sensors -c sensors-PCChips
> (...)
> in4:       +0.19 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> 
> Seems like in4 dropped completely?
> Wait: it seemed like a flatcable dropped on the fan, and stopped it 
> spinning. So I guess +0,19V is suppose to say "Way to hot: you're burning 
> your fingers!"? (Since I actually did burn my finger)
> 
> But one minute after the fan started spinning again...
> (...)
> in4:       +0.00 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> 
> And 30 seconds later:
> (...)
> in4:       +4.03 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> 
> After a complete cooldown period (30 mins idling)
> (...)
> in4:       +3.42 V  (min =  +0.00 V, max =  +0.00 V)   ALARM

Strange. The value changes, so I was probably right that in4 was
connected to a thermal sensor, but OTOH, the values look odd. The
first two and last values suggest that +3.55 V / +3.42 V corresponds to
the normal running temperature, and +0.19 V means the CPU is very hot,
but the 3rd and 4th values don't really fit in that model. Or maybe it
was just too hot and the sensor got confused for some time, I don't
know.

> Is there any way to get information from PCCHIPS, or is it just a waste of 
> time to request information from them?

If the board is 10-year old, it's probably hopeless, but it depends on
how much you want to get it to work and how much time you are ready to
spend on it.

If you can't get additional information, you can label in4 "CPU Temp",
observe the reading over a period of time, and set arbitrary limits
accordingly. Unfortunately we have no way to tell "sensors" that a
voltage input is actually a temperature value.

> > Well, I crafted the configuration file to make it look good, so it
> > doesn't mean much ;)
>
> Is there actually any way to see if it is correct, not involving to use a 
> multimeter? I lost mine, so I should buy a new one ;p

The other possibilities are asking PCChips, or attempting to
disassemble the BIOS.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

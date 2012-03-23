From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Mar 2012 08:14:56 +0000
Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
Message-Id: <20120323081456.GA28622@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
In-Reply-To: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 23, 2012 at 04:00:35AM -0400, Tomas Johansson wrote:
> Hi!
> 
> I have a Gigabyte GA-P67A-UD5-B3 with a IT8728F, yesterday i upgraded to Linux
> 3.3 and tested the new IT87 module.
> As i will show below it shows wrong CPU temperature.
> 
> First:
> 
> temp1 shows system or motherboard if you want.
> temp2 shows ?, probably unused
> temp3 shows CPU but is 7-8 degrees wrong compared to BIOS (I know that temp3 is
> CPU because it is the only temp value that differ under load)
> 
> 
> BIOS at this moment in time showed:
> SYS 34 C
> CPU 32 C
> 
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +36.0 C  (high = +80.0 C, crit = +98.0 C)
> Core 0:         +36.0 C  (high = +80.0 C, crit = +98.0 C)
> Core 1:         +35.0 C  (high = +80.0 C, crit = +98.0 C)
> Core 2:         +33.0 C  (high = +80.0 C, crit = +98.0 C)
> Core 3:         +35.0 C  (high = +80.0 C, crit = +98.0 C)
> 
> it8728-isa-0290
> Adapter: ISA adapter
> in0:          +1.08 V  (min =  +0.00 V, max =  +3.06 V)
> in1:          +2.03 V  (min =  +0.00 V, max =  +3.06 V)
> in2:          +2.96 V  (min =  +0.00 V, max =  +3.06 V)
> in3:          +2.93 V  (min =  +0.00 V, max =  +3.06 V)
> in4:          +0.24 V  (min =  +0.00 V, max =  +0.84 V)
> in5:          +1.20 V  (min =  +0.00 V, max =  +3.06 V)
> in6:          +1.55 V  (min =  +0.00 V, max =  +3.06 V)
> 3VSB:         +3.38 V  (min =  +0.00 V, max =  +6.12 V)
> Vbat:         +3.26 V  
> fan1:        1056 RPM  (min =    0 RPM)
> fan2:           0 RPM  (min =    0 RPM)
> fan3:           0 RPM  (min =    0 RPM)
> fan4:           0 RPM  (min =    0 RPM)
> fan5:        1374 RPM  (min =    0 RPM)
> temp1:        +34.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> temp2:        +31.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> temp3:        +25.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> intrusion0:  ALARM
> 
> 
> 
> Conclusion:
> 
> fan1, shows correct value.
> fan5, shows correct value.
> temp1 (system), shows correct value.
> temp3 (CPU), shows wrong value, in this case 25 C instead of 32 C.
> 
I am a bit lost here. Why do you assume that temp2 (which would show roughly
the correct temperature) is unused, and that temp3 is the CPU temperature ?
Why not temp2=CPU and temp3=??? 

What happens if you run something challenging on the system ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

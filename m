From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Jun 2011 18:17:30 +0000
Subject: Re: [lm-sensors] Getting started with lm-sensors
Message-Id: <1308075450.8271.366.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <628947.18593.qm@web65411.mail.ac4.yahoo.com>
In-Reply-To: <628947.18593.qm@web65411.mail.ac4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-06-14 at 12:03 -0400, Guillermo de las Nieves wrote:
> Good afternoon!
> 
> 
> I'm getting started with lm-snesors, trtying to do my thesis about
> energy consumption in network adapters (LAN, WIFI...).
> 
> 
> I'm looking for some guidance, since when I execute the command
> sensors I obtain:
> 
> 
> gnieves@pupa:~$ sensors
> it8718-isa-0290
> Adapter: ISA adapter
> in0:         +1.22 V  (min =  +0.00 V, max =  +4.08 V)   
> in1:         +1.79 V  (min =  +0.00 V, max =  +4.08 V)   
> in2:         +3.30 V  (min =  +0.00 V, max =  +4.08 V)   
> in3:         +2.93 V  (min =  +0.00 V, max =  +4.08 V)   
> in4:         +0.19 V  (min =  +0.00 V, max =  +4.08 V)   
> in5:         +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
> in6:         +1.25 V  (min =  +0.00 V, max =  +4.08 V)   
> in7:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)   
> Vbat:        +4.08 V
> fan1:       1634 RPM  (min =    0 RPM)
> fan2:          0 RPM  (min =    0 RPM)
> fan3:          0 RPM  (min =    0 RPM)
> temp1:       -55.0°C  (low  = +127.0°C, high = +127.0°C)  sensor > thermistor
> temp2:       +38.0°C  (low  = +127.0°C, high = +127.0°C)  sensor > thermal diode
> temp3:        -1.0°C  (low  = +127.0°C, high = +127.0°C)  sensor > thermistor
> cpu0_vid:   +1.288 V
> 
> 
> 
> I got some idea about what each inX means, but still not sure about
> it. And I know that this is not calibrated.
> My questions are, where can I found what exactly means each inX, is
> this useful to check the energy consumption on the network device and
> finally, how can i calibrate this?
> 
inX reflects voltages, so it won't help you to determine energy
consumption. Standard PCs don't usually support power or current
measurements. Also, above information is not specific to a network
adapter, but to your system's mainboard. I don't know of any PC network
adapters with current/voltage sensor support.

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

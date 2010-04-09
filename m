From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Apr 2010 07:24:29 +0000
Subject: Re: [lm-sensors] Soltek K8T800Pro (it87-isa-0290),
Message-Id: <20100409092429.023dfcef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BBA227C.7010205@shaw.ca>
In-Reply-To: <4BBA227C.7010205@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Thu, 08 Apr 2010 16:50:41 -0700, Moofie wrote:
> Moofie wrote:
> > Hello list, this is my first time posting here, and I come with some 
> > questions about my server motherboard with the hopes that I configure 
> > sensors on it correctly.
> > 
> > While this Soltek board is relatively old (as the company is no longer 
> > in business), I had never used it since the day that I bought it.  The 
> > board was recently installed into a server role and I hope to monitor 
> > its health from a distance.
> > 
> > While sensors detects the correct chips installed on the board, the 
> > values are useless.
> > 
> > I'm wondering if anyone can shed light on how to set the values 
> > correctly for this board.  Here's some pertinent info:
> > 
> > 
> > 
> > ITE IT8712F, National LM90 (ISA 290h, SMBus 4Ch)
> > 
> > 
> > 
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:       +40.0°C  (crit = +75.0°C)
> > 
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:  +50.0°C
> > Core1 Temp:  +42.0°C
> > 
> > it87-isa-0290
> > Adapter: ISA adapter
> > in0:         +1.31 V  (min =  +0.00 V, max =  +4.08 V)
> > in1:         +2.54 V  (min =  +0.00 V, max =  +4.08 V)
> > in2:         +3.28 V  (min =  +0.00 V, max =  +4.08 V)
> > in3:         +2.90 V  (min =  +0.00 V, max =  +4.08 V)
> > in4:         +2.91 V  (min =  +0.00 V, max =  +4.08 V)
> > in5:         +0.96 V  (min =  +0.00 V, max =  +4.08 V)
> > in6:         +1.12 V  (min =  +0.00 V, max =  +4.08 V)
> > in7:         +2.94 V  (min =  +0.00 V, max =  +4.08 V)
> > Vbat:        +3.26 V
> > fan1:       11250 RPM  (min = 3245 RPM)
> > fan2:       4963 RPM  (min =    0 RPM)
> > temp1:       +26.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = 
> > thermistor
> > temp2:       -86.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = 
> > thermal diode
> > temp3:       +14.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = 
> > thermistor
> > 
> > lm90-i2c-0-4c
> > Adapter: SMBus Via Pro adapter at 5000
> > temp1:       +38.0°C  (low  =  +0.0°C, high = +70.0°C)
> >                       (crit = +85.0°C, hyst = +75.0°C)
> > temp2:       +63.1°C  (low  =  +0.0°C, high = +70.0°C)
> >                       (crit = +85.0°C, hyst = +75.0°C)
> > 
> > 
> > If I can provide more information, let me know.
>
> OK, I give, what is the LM90 chip usually used for?

Monitoring temperature.

> I understand that temp1 is its own temperature.

Yes it is.

> Though is that basically the only use of an lm90 chip?  To test one
> local and one remote temperature?

Well, yes, that's a temperature monitoring chip, what else would you
want it to be used for?

> What have people used in real world examples for this chip?  Usually M/B 
> temp and CPU temp?  I see that temp2 jumps with the CPU temperature, I'm 
> going to assume it's correct as it matches the BIOS readings and I will 
> label it as such.

Yes, temp1 = M/B temperature and temp2 = CPU temperature is the most
typical usage for LM90-like chips on mainboards. On graphics cards,
they are used as temp1 = card temperature and temp2 = GPU temperature.

> Though the k8 temps measure each core.  And... They're off by a few 
> degrees (12C in the above example) so which should I take as correct? 
> None of the above examples have compute lines so they seem to be as raw 
> as lm-sensors believes them to be.

The K8 internal sensors have not impressed us by their reliability so
far. See the note on http://www.lm-sensors.org/wiki/Devices and various
reports on this list.

The LM90 temp1 reading should be accurate out of the box, no compute
statement needed. The LM90 temp2 reading might need an offset,
depending on the thermal diode model being used. Ideally, the BIOS
would have set it up properly, so that it itself reports accurate
temperature readings. I agree that the LM90 temp2 value is quite high
on your system, but I would tend to trust it, especially if the BIOS
reports the same.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

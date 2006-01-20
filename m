From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 20 Jan 2006 07:42:50 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060120084250.325f7cc6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> > If you can observe anything more detailed (e.g. how or when exactly the
> > values change), please let us know. Also, please confirm that the limit
> > values are always correct right after running "sensors -s && sleep 3 &&
> > sensors".
>
> I'm pretty sure that its occurring (randomly) after a cold boot -- I say 
> randomly because I still haven't detected a pattern and because not 
> every cold boot generates a change (even those after over night down 
> time).   However, I wouldn't rule out the BIOS though either.

If it is changing on boot only, it could be explained by the chip not
having well-defined power-up default values for these registers.

> Actually, another thing I've noticed is that since the time I added the 
> initial configuration settings to sensors.conf, its only been the "high" 
> (or temp1_max) value that I've now seen change .  The "hysteresis" value 
> has been constant at 52C.

Related to an error of mine, see right below.

> Running "sensors -s && sleep 3 && sensors" hasn't affected a change to 
> the values.  However, it does generate some errors:
> 
> # sensors -s && sleep 3 && sensors
> Error: Line 2437: Unknown feature name
> Error: Line 2439: Unknown feature name
> Error: Line 2441: Unknown feature name
> w83687thf-isa-0290: No such feature known

Hm, this is bad, and my bad. The sample configuration file I sent to
you had some mistakes. Attached is a fixed version, which should fix
these errors. "sensors -s" should now properly set high temperature
limits.

If any limit changes unexpectedly after that again, please report.

> lm90-i2c-0-4c
> Adapter: SMBus Via Pro adapter at 5000
> 
> M/B Temp:    +37?C  (low  =   +10?C, high =   +50?C)
> CPU Temp:  +55.4?C  (low  = +10.0?C, high = +70.0?C)
> M/B Crit:    +70?C  (hyst =   +65?C)
> CPU Crit:    +80?C  (hyst =   +75?C)
> 
> w83687thf-isa-0290
> Adapter: ISA adapter
> Vcore:     +1.10 V  (min =  +1.05 V, max =  +1.47 V)
> +1.5V:     +1.52 V  (min =  +1.42 V, max =  +1.57 V)
> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +5.03 V  (min =  +4.76 V, max =  +5.24 V)
> Vdimm:     +2.59 V  (min =  +2.46 V, max =  +2.74 V)
> 5VSB:      +4.95 V  (min =  +4.76 V, max =  +5.24 V)
> Vbat:      +3.30 V  (min =  +2.85 V, max =  +3.47 V)
> Case Fan: 1339 RPM  (min = 1102 RPM, div = 8)
> CPU Fan:  1406 RPM  (min = 1102 RPM, div = 8)
> M/B Temp:    +40?C  (high =    +6?C, hyst =   +52?C)   sensor = diode
> CPU Ext:   +40.5?C  (high =   +80?C, hyst =   +52?C)   sensor = diode
> CPU Int:   +60.0?C  (high =   +80?C, hyst =   +65?C)   sensor = diode
> alarms:
> beep_enable:
>           Sound alarm enabled

Everything else looks quite good here :)

> > Well if that's a BIOS bug there's not much we can do. What we should
> > offer OTOH is a full interface to the chip to tweak the automatic fan
> > speed in a much more detailed (and accurate, in your case) way than the
> > BIOS offers. There's a patch flaoting around, but nobody (counting me)
> > had the time to actually merge it. Shame on us.
>
> Do tell.  Is this patch specific to Winbond's thermal cruise?  In the 
> meantime I'll google for it.

The patch is even more specific than this. It is specific to the
Winbond W83627THF. Getting it to work with the W83687THF should be
possible as both chips seem to share most of their features, but this
would need to be checked carefully.

> > No. As you can see, "sensors" doesn't show the value either. +12V is
> > simply not wired to the monitoring chip on your board. That's a
> > physical issue.
> 
> Ah, I see.   Any rationale behind that decision of board makers that you 
> know of?

Every manufacturer is free to monitor whatever they want on every
single board the design. There are no rules. Given that the W83687THF
can monitor "only" 7 voltage inputs, and a regular system usually has
10 these days, Soltek had to make a choice. They discarded -5V, -12V
and +12V. That's not a bad choice if you want my opinion. Negative
voltages are unused in modern systems as far as I know, and pretty much
every single recent board we've had a report for did not monitor them
anymore.

+12V probably tends to be less and less used too, as lower
voltages are used in recent designs. CPUs were powered with 3.5V tens
years ago, and now most are in the 1.0-1.6V range. The AGP voltage is
as low as 1.5V. Recent chips are powered with +3.3V instead of +5V, and
Winbond even dropped their 16mV LSB ADC for a 8mV LSB ADC in one of
their most recent chips (W83627EHF), so you can monitor raw voltages in
the 0-2.04V range instead of 0-4.08V range. See, all voltages are
slowly getting lower. As far as I know, +12V is only used for drive
motors in our computers now - or to derive lower voltages.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-Soltek-B9D-FGR.conf
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060120/0019ca04/sensors-Soltek-B9D-FGR.pl

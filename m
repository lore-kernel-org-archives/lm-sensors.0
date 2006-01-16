From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 16 Jan 2006 22:20:31 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060116232031.1d490d87.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

Thanks for your detailed answer.

> Will try, but I haven't observed any correlation yet as to why it 
> changes.  I should, however, clarify that "fluctuating" was an 
> inappropriate label. 
> The values will remain steady for a good long while, even across days.  
> But then, without apparent reason, "sensors" will unveil that they have 
> changed.  For example, I'm now seeing:
> temp1:       +38?C  (high =    +2?C, hyst =   +52?C)   sensor = diode

When does the values change? If on reboot or deep sleep, it might just
mean that these registers have no default power-up value. If on the
other hand the values change during the regular system use, I'd
diagnose a chip failure - it shouldn't lose the register values that
way. Or something (BIOS?) is writing crap to these registers. Not much
we can do in either case, I fear.

If you can observe anything more detailed (e.g. how or when exactly the
values change), please let us know. Also, please confirm that the limit
values are always correct right after running "sensors -s && sleep 3 &&
sensors".

> Anyways, while placing the system under load, it appeared that the 
> trigger for the SmartFan1 (throttling of the CPU fan) was the Winbond 
> temp3.  Seemingly, if that sensor's reading breached >66C for more then 
> two occasions in a row, the cpu fan ramped up (The LM90's CPU temp was 
> already bouncing around in low 70s and seemed to play no part).  * This 
> is why I stated earlier that I believe the BIOS' "CPU Internal Temp" 
> corresponds to the Winbond IC and not the LM90.

As a side note, these are quite high temperatures you have here. I know
that modern CPUs are supposed to support such high temperatures, but
I'm not sure all components of your system will have a long life at
this temperature. You may consider a superior cooling system.

> ** If needed or if it might help in anyway (in relation to the current 
> discussion or perhaps even for assisting future efforts to support for 
> the "thermal cruise" mode),  I can find and provide links to the 
> discussion I had with Lydia and they would provide a more detailed 
> description of my observations about the wonky SpeedFan behaviour.

Well if that's a BIOS bug there's not much we can do. What we should
offer OTOH is a full interface to the chip to tweak the automatic fan
speed in a much more detailed (and accurate, in your case) way than the
BIOS offers. There's a patch flaoting around, but nobody (counting me)
had the time to actually merge it. Shame on us.

> > > - Interesting that there is no +12V reading
> >
> > True, that's unusual, but not unseen.
>
> Would this be strictly a BIOS limitation of not exposing such monitoring?

No. As you can see, "sensors" doesn't show the value either. +12V is
simply not wired to the monitoring chip on your board. That's a
physical issue.

> $ sensors
> lm90-i2c-0-4c
> Adapter: SMBus Via Pro adapter at 5000
> M/B Temp:    +36?C  (low  =   +10?C, high =   +50?C)
> CPU Temp:  +52.8?C  (low  = +10.0?C, high = +70.0?C)
> M/B Crit:    +70?C  (hyst =   +65?C)
> CPU Crit:    +80?C  (hyst =   +75?C)
> 
> w83687thf-isa-0290
> Adapter: ISA adapter
> Vcore:     +1.09 V  (min =  +1.04 V, max =  +1.47 V)
> +1.5V:     +1.52 V  (min =  +1.42 V, max =  +1.57 V)
> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +5.03 V  (min =  +4.76 V, max =  +5.24 V)
> Vdimm:     +2.59 V  (min =  +2.46 V, max =  +2.74 V)
> 5VSB:      +4.95 V  (min =  +4.76 V, max =  +5.24 V)
> Vbat:      +3.30 V  (min =  +2.85 V, max =  +3.47 V)
> fan1:        0 RPM  (min = 1102 RPM, div = 8)              ALARM
> fan2:     1394 RPM  (min = 1102 RPM, div = 8)
> temp1:       +39?C  (high =    +2?C, hyst =   +52?C)   sensor = diode
> temp2:     +38.0?C  (high =   +80?C, hyst =   +52?C)   sensor = diode
> temp3:     +56.0?C  (high =   +80?C, hyst =   +65?C)   sensor = diode
> vid:      -4.825 V  (VRM Version 2.4)
> alarms:
> beep_enable:
>           Sound alarm enabled

Looks rather good already.

> Notes:
> - fan1 is, of course, the exhaust fan which is currently unplugged and 
> sitting on my desk.
> - vid is obviously incorrect

Looks like on your system, the VID pins are used for an alternative
function (game port/MIDI) so you wouldn't have a valid reading anyway.
That left apart, the bug (vid shouldn't show at all in this case) is
fixed in later versions of the kernel already. For now you can simply
ignore this value.

Attached is an updated version of the configuration file. Everything
should look OK now.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-Soltek-B9D-FGR.conf
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060116/b5c66a12/sensors-Soltek-B9D-FGR-0001.pl

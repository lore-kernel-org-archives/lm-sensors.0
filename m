From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Thu, 19 Jan 2006 05:07:40 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43CF1E9C.3020507@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Sorry for the delay in replying.

Jean Delvare wrote:
> When does the values change? If on reboot or deep sleep, it might just
> mean that these registers have no default power-up value. If on the
> other hand the values change during the regular system use, I'd
> diagnose a chip failure - it shouldn't lose the register values that
> way. Or something (BIOS?) is writing crap to these registers. Not much
> we can do in either case, I fear.
>
> If you can observe anything more detailed (e.g. how or when exactly the
> values change), please let us know. Also, please confirm that the limit
> values are always correct right after running "sensors -s && sleep 3 &&
> sensors".
>   
I'm pretty sure that its occurring (randomly) after a cold boot -- I say 
randomly because I still haven't detected a pattern and because not 
every cold boot generates a change (even those after over night down 
time).   However, I wouldn't rule out the BIOS though either.

Actually, another thing I've noticed is that since the time I added the 
initial configuration settings to sensors.conf, its only been the "high" 
(or temp1_max) value that I've now seen change .  The "hysteresis" value 
has been constant at 52C.

Running "sensors -s && sleep 3 && sensors" hasn't affected a change to 
the values.  However, it does generate some errors:

# sensors -s && sleep 3 && sensors
Error: Line 2437: Unknown feature name
Error: Line 2439: Unknown feature name
Error: Line 2441: Unknown feature name
w83687thf-isa-0290: No such feature known
lm90-i2c-0-4c
Adapter: SMBus Via Pro adapter at 5000

M/B Temp:    +37?C  (low  =   +10?C, high =   +50?C)
CPU Temp:  +55.4?C  (low  = +10.0?C, high = +70.0?C)
M/B Crit:    +70?C  (hyst =   +65?C)
CPU Crit:    +80?C  (hyst =   +75?C)

w83687thf-isa-0290
Adapter: ISA adapter
Vcore:     +1.10 V  (min =  +1.05 V, max =  +1.47 V)
+1.5V:     +1.52 V  (min =  +1.42 V, max =  +1.57 V)
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.03 V  (min =  +4.76 V, max =  +5.24 V)
Vdimm:     +2.59 V  (min =  +2.46 V, max =  +2.74 V)
5VSB:      +4.95 V  (min =  +4.76 V, max =  +5.24 V)
Vbat:      +3.30 V  (min =  +2.85 V, max =  +3.47 V)
Case Fan: 1339 RPM  (min = 1102 RPM, div = 8)
CPU Fan:  1406 RPM  (min = 1102 RPM, div = 8)
M/B Temp:    +40?C  (high =    +6?C, hyst =   +52?C)   sensor = diode
CPU Ext:   +40.5?C  (high =   +80?C, hyst =   +52?C)   sensor = diode
CPU Int:   +60.0?C  (high =   +80?C, hyst =   +65?C)   sensor = diode
alarms:
beep_enable:
          Sound alarm enabled


> As a side note, these are quite high temperatures you have here. I know
> that modern CPUs are supposed to support such high temperatures, but
> I'm not sure all components of your system will have a long life at
> this temperature. You may consider a superior cooling system.
>   
Cooling for SFF systems, given the tight quarters, is problematic to 
begin with, but this case's internal design seems to only compound that 
issue....and although my results (with the stock cooling system) are 
consistent with those reported by other users, I find that of little 
consolation, as the temps I have reported are indeed pretty unimpressive.

The exhaust fan (which is essentially similar to a pci slot blower fan) 
is pitifully ineffective -- it makes only a marginal amount of 
difference, but certainly adds to the noise profile.  The CPU cooler and 
the PSU fan also are in direct competition for air flow ... and speaking 
of airflow, its pretty poor.

I would love to make some modifications, but given the internal layout, 
it would require a good deal of thought and time to come up with 
something that can overcome the present deficiencies.  And time is 
probably the biggest factor working against making such an effort.

> Well if that's a BIOS bug there's not much we can do. What we should
> offer OTOH is a full interface to the chip to tweak the automatic fan
> speed in a much more detailed (and accurate, in your case) way than the
> BIOS offers. There's a patch flaoting around, but nobody (counting me)
> had the time to actually merge it. Shame on us.
>   
Do tell.  Is this patch specific to Winbond's thermal cruise?  In the 
meantime I'll google for it.

>>>> - Interesting that there is no +12V reading
>>>>         
>>> True, that's unusual, but not unseen.
>>>       
>> Would this be strictly a BIOS limitation of not exposing such monitoring?
>>     
>
> No. As you can see, "sensors" doesn't show the value either. +12V is
> simply not wired to the monitoring chip on your board. That's a
> physical issue.
>   

Ah, I see.   Any rationale behind that decision of board makers that you 
know of?

>> vid:      -4.825 V  (VRM Version 2.4)
> Looks like on your system, the VID pins are used for an alternative
> function (game port/MIDI) so you wouldn't have a valid reading anyway.
> That left apart, the bug (vid shouldn't show at all in this case) is
> fixed in later versions of the kernel already. For now you can simply
> ignore this value.
>
> Attached is an updated version of the configuration file. Everything
> should look OK now.
>   

Indeed it does (see above for output).  Much appreciation.

Thanks, Steven



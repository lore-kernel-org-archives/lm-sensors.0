From: jschrod@acm.org (Joachim Schrod)
Date: Fri, 13 Jan 2006 11:57:51 +0000
Subject: [lm-sensors] Questions on sensors.conf
Message-Id: <dq84k0$d0l$1@sea.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <dq6sc5$n2s$1@sea.gmane.org>
In-Reply-To: <dq6sc5$n2s$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Philip Pokorny wrote:

>>The system has an Intel D865GBF ATX Mainboard
>>
> That should be fairly similar to the D865PERL which was one of the MB on 
> which the lm85 driver was originally developed and tested.

That's interesting. Anybody has a sensors.conf for a D865PERL board that he is 
willing to share? I didn't found one in the list archive.

The example configuration in sensors.conf.eg is for an Intel S845WD1-E and I 
started with that.

 >> [temperature is higher in BIOS than reported by lm_sensors]
 >
> Be careful.  When a CPU is sitting in the BIOS, it is usually in a 
> spin-loop which usually puts the CPU in a maximum power situation.  So 
> the CPU temperatures in the BIOS will frequently be higher than you 
> observe under an operating system like Linux where the CPU is put into 
> the HALT state when there isn't any work to do.
 >
 > Unless the values are *way* off, or you have a way to measure the same
 > temperature or value using independant means _at the same time_, I would
 > recommend you *not* adjust the readings returned by an lm_sensors chip
 > driver.

OK, then I'll trust the sensors readings. Sadly, ACPI doesn't have thermal 
information (the board's DSDT also has no _TMP variable, so this seems to be 
deliberate), so I cannot get at the temperature in an independent way.

 > Did the BIOS program the temp#_offset registers?  Can you report the
 > values from those configuration registers?

I assume that they would appear in /sys, if they would be registered, right?
There are no temp#_offset variables.
There are temp#_auto_temp_off variables, with 86000 as content.

> The "Board" sensor (temp2) is actually internal to the lm85 chip.  So if 
> you can *find* the chip which is labeled lm85, that will be the location 
> of that temperature...
 >
 > A temperature sensor on
 > the motherboard that is close to a high power component or function like
 > the VRM (Vcore power supply) for the CPU *will* read higher than ambient
 > because heat from the power transistors in the VRM disipate heat through
 > the copper traces on the motherboard and the motherboard itself.  This
 > heats components near them on the motherboard.  It wouldn't be
 > unreasonable for the "Remote" temperature sensor to in fact be located
 > very near the VRM to in effect measure the temperature of the VRM.

Hmm, didn't find the lm85 chip at first sight. And I don't want to rip out all 
cards to check the board more thoroughly. Sadly, the board documentation (from
http://www.intel.com/design/motherbd/bf/bf_documentation.htm, in the spec 
update) has information about its hot zones -- but not about the temperature 
measurement zones.

So I think I don't have much further chance to associate the temp# measurements 
to board or chassis areas. Maybe temp3 is near such a `hot zone' because it's 
higher than temp2.

> Generally, I'm surprised that the limits are set this low.  They are too 
> low for a P4 CPU. 

That would have been my next question -- what are good limits? :-)

I looked up the P4 specs, at 
http://download.intel.com/design/Pentium4/datashts/29864312.pdf

It tells that the chassis temperature shall be between 5 and 70?C, that would 
have been my first guess at temp1_min and temp1_max.

But both the P4 and the board documentation also tell me that the ``chassis' 
maximum internal ambient temperatur'' shall be 38?C. Actually, that shall be the 
temperature at the CPU's fan heatsink, with a worst case limit of 40?C (on p.84 
of the P4 datasheet).

So, maybe that 38 or 40? are good values for temp2_max or temp3_max?


On i2c/lm_sensors documentation:

>>There is temp#_min, temp#_max, temp#_hyst, and temp#_over.
>>  
>>min and max are not explained.
>>  
> What documentation are you reading?

All that I could found. I downloaded the current 2.9.2 distribution to be sure 
that I got the current docs. I even checked some of the files in CVS.

I looked in sensors.conf.eg, doc/chips/lm85, the FAQ and did a grep of 
'temp.*_min' over doc/chips/*. I also looked at the Web site. I found the 
explanation of hyst and over in sensors.conf.eg, but none for min and max.

Anyhow, your following explanation was sufficient for me. :-)

> But in the 2.6 kernel, the lm_sensors team tried to enforce a consistent 
> set of values for automatic fan speed control.  So at least in 2.6.13, 
> the name and values have changed and things are worked around in the 
> driver to present the "standard" interface values:
>    temp#_auto_temp_{off,min,max,crit}
>    pwm#_auto_pwm_{min,minctl,freq}

OK. Is there a documentation that explains them?
Neither the lm_sensors nor the i2c distribution mentions them.
I also checked the list's archive and couldn't locate an explanation.

In some emails to this list a Linux kernel documentation file 
i2c/sysfs-interface is mentioned, but I only have one from Linux 2.6.8 (SUSE 
9.2) where these variables are not mentioned; and in 2.6.13 (SUSE 10.0) this 
file disappeared.

I ask because the values in these files are quite high. (If I interpret them 
correctly as millidegrees C.)

temp1_auto_temp_off	86000
temp1_auto_temp_min	90000
temp1_auto_temp_crit	100000
temp1_auto_temp_max	122000

Do they make sense? What are their semantics?

Sorry for the loads of questions, but I actually want to understand what's going 
on on my system. :-)

	Joachim

--
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Joachim Schrod				Email: jschrod at acm.org
Roedermark, Germany



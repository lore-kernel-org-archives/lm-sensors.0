From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Fri, 13 Jan 2006 21:47:24 +0000
Subject: [lm-sensors] Questions on sensors.conf
Message-Id: <43C81FEC.6040807@jellyfish.highlyscyld.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <dq6sc5$n2s$1@sea.gmane.org>
In-Reply-To: <dq6sc5$n2s$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Joachim Schrod wrote:

>Philip Pokorny wrote:
> > Unless the values are *way* off, or you have a way to measure the same
> > temperature or value using independant means _at the same time_, I would
> > recommend you *not* adjust the readings returned by an lm_sensors chip
> > driver.
>
>OK, then I'll trust the sensors readings. Sadly, ACPI doesn't have thermal 
>information (the board's DSDT also has no _TMP variable, so this seems to be 
>deliberate), so I cannot get at the temperature in an independent way.
>  
>
No, ACPI would just be reporting the values from the same sensor chip.  
Independant in this case would be a thermocouple, thermometer, or 
non-contact temperature sensor.

> > Did the BIOS program the temp#_offset registers?  Can you report the
> > values from those configuration registers?
>
>I assume that they would appear in /sys, if they would be registered, right?
>There are no temp#_offset variables.
>  
>
Perhaps I'm confusing this with another chip.  Nevermind.

>>Generally, I'm surprised that the limits are set this low.  They are too 
>>low for a P4 CPU. 
>>    
>>
>
>That would have been my next question -- what are good limits? :-)
>
>I looked up the P4 specs, at 
>http://download.intel.com/design/Pentium4/datashts/29864312.pdf
>
>It tells that the chassis temperature shall be between 5 and 70?C, that would 
>have been my first guess at temp1_min and temp1_max.
>  
>
No, that's not "chassis" temperature, that's the temperature of the 
lid/case of the CPU itself.  But the temperature reported by the lm85 is 
not the case temperature.  It the temperature of a sensing diode on the 
CPU die itself which will be several degrees hotter than the case 
temperature because it's inside the CPU package.

If you check the "Thermal Diode" section of that spec, you'll see that 
the diode is "characterized" at 75 degC.  
(Note 2)  There isn't a spec for the actual Tjunction temperature for a 
P4, but I would guess that 75 deg is a better value for the maximum CPU 
temperature.

>But both the P4 and the board documentation also tell me that the ``chassis' 
>maximum internal ambient temperatur'' shall be 38?C. Actually, that shall be the 
>temperature at the CPU's fan heatsink, with a worst case limit of 40?C (on p.84 
>of the P4 datasheet).
>
>So, maybe that 38 or 40? are good values for temp2_max or temp3_max?
>  
>
Yes, if they were measuring air temperature.  But since they are mounted 
on the board and perhaps located next to hot components, you may need to 
increase them a little as well.  But start with 40 and see how it goes.

:v)


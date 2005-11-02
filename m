From: roger@planbit.co.uk (Roger Lucas)
Date: Wed, 02 Nov 2005 10:25:26 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Knut,

It looks like it is working on your system too. :-)

Thanks for you help in testing this out.

I posted a revised patch update to the mailing list yesterday - I got a
whole load of change requests from Jean.  Most of these were cosmetic or
minor performance changes, but I would suggest that you update if possible.

The fan is handled correctly, but you have the nasty condition where if you
set a minimum speed that is too low, it is set to zero.  The Via speed
sensor works on period rather than frequency, so there is a 1/x conversion
done in the driver.  If you select a frequency that is too low, then the
conversion to a period creates a period that is too large for the counters
and the resulting illegal result is rejected.  If you want very slow fan
speeds then you must make sure the divider is set high enough so that the
resulting period is within the limits of the device.

Personally, I don't like this.  It isn't really a massive amount of work to
get the driver to automatically either:

1) Automatically select the appropriate divider for the minimum speed that
you have requested (i.e. pick the highest divider ratio that can give the
speed you want range)

Or
2) Select the lowest possible minimum speed if the one you selected is still
too low.

A minimum speed of 0 should always disable the minimum speed detection.
Resetting the minimum speed to zero when you select a non-zero minimum speed
is just plain wrong, however, as it is not obvious exactly what is happening
"behind the scenes".  I spent quite a bit of time debugging the system to
convince myself it was working "correctly".

What are your thoughts on this?

Anyone else have thoughts on this?

- Roger

-----Original Message-----
From: Knut Petersen [mailto:Knut_Petersen@t-online.de] 
Sent: 02 November 2005 08:53
To: Roger Lucas
Subject: Re: vt8231.c

Hi Roger,

>
>
>Attached is a patch file for the 2.6.14 kernel tree.  I have also attached
>my sensors.conf file.
>
>Please could you try this and let me know if it works for you?
>
>

linux:/etc # sensors
vt8231-isa-6000
Adapter: ISA adapter
+12v:     +11.96 V  (min = +11.37 V, max = +12.56 V)  
+5v:       +5.21 V  (min =  +4.73 V, max =  +5.24 V)  
+2.5v:     +2.46 V  (min =  +2.42 V, max =  +2.57 V)  
Vcore1 (1.2v):
           +1.22 V  (min =  +1.14 V, max =  +1.25 V)  
+3.3V:     +3.35 V  (min =  +3.13 V, max =  +3.45 V)  
fan1:     11808 RPM  (min =    0 RPM, div = 1)         
fan2:        0 RPM  (min =    0 RPM, div = 2)         
Proc Temp: +45.1?C  (high =  +268?C, hyst =   -59?C)  
vid:       +1.85 V

eeprom-i2c-0-51
Adapter: SMBus Via Pro adapter at 5000
Memory type:            SDR SDRAM DIMM
Memory size (MB):       512



Voltages:
===+5V is within 0.02V with my multimeter,
+12V is about 0.16V low according to my multimeter

Temperature:
====The displayed value is believable.

Fans:
==
I connected a fan for tests. It?s a Verax fan with 9 pulses / revolution.

In sensors.conf I used the four dividers 1,2,4,9 instead of the *:

    set fan1_div *
    set fan1_min 1000

Here are the results

1:    fan1:     12024 RPM  (min =    0 RPM, div = 1)
2:    fan1:     11702 RPM  (min =    0 RPM, div = 2)
4:    fan1:     11702 RPM  (min =    0 RPM, div = 4)
8:    fan1:     12603 RPM  (min =  999 RPM, div = 8)
9:    fan1:     11915 RPM  (min =    0 RPM, div = 2)

Obviously the fan1_min are ignored most of the time and dividers are not 
handled correctly.
The datasheet of the fan lists 1500 rpm for a temperature of 30? Celsius 
and about 1200 rpm
for 20? Celsius. So 12024/9 = 1336 rpm is believable.

cu,
 knut


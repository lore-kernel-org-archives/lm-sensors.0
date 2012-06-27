From: Michael Zintakis <michael.zintakis@googlemail.com>
Date: Wed, 27 Jun 2012 23:00:56 +0000
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Message-Id: <4FEB90A8.8050901@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FEA4C10.2060904@googlemail.com> <20120627171505.GB12712@roeck-us.net>
In-Reply-To: <20120627171505.GB12712@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hello Guenter and All,


> Please see http://hansdegoede.livejournal.com/7932.html; it should explain what
> is going on.
>   
This is precisely what I stumbled upon when reading the documentation 
about the kernel acpi parameters today and tried it straight away 
(though, in all honesty, I didn't have a clue that it is actually a bad 
idea until I read the article above - thanks for posting!). Could any of 
the more knowledgeable on here explain why is it such a bad idea please?

I also tried another, much cleaner solution which was described in that 
kernel documentation file, namely:

memmap=nn[KMG]$ss[KMG]
            [KNL,ACPI] Mark specific memory as reserved.
            Region of memory to be used, from ss to ss+nn.
            Example: Exclude memory from 0x18690000-0x1869ffff
                     memmapdK$0x18690000
                     or
                     memmap=0x10000$0x18690000

So, I tried to use the following kernel command line parameter: 
"memmap=0x08$0x00000290" in order to force ACPI to mark this memory 
space as "reserved" and not use it, but that didn't work for some 
reason. When I tried to load the f71882fg driver the same error 
happened. :-(

The only solution, it seems, is by using "acpi_enforce_resources=lax" - 
that way it all works out.

Relying on ACPI is not an option for me whatsoever - I am using this 
board to run critical applications 24/7 and I *need* to have active fan, 
voltage and temperature management at *all* times.

ACPI cannot provide that!

The only piece of software which could provide what I need is the 
f71882fg driver and it does it very well, though, there I have one 
issue, which you, or anyone else could address for me, if possible. The 
issue is this:

Initially, when the board is first powered up, all fans (all 3 of them) 
are at a standstill because the board temperature is low. After some 
time passes by, when the temperature starts to rise steadily, it comes a 
point where the BIOS/the f71882fg driver increase the pwm parameter of 
the fans, but there comes a problem: due to the fact that the current 
increase is very gentle and also due to the fact of the actual physical 
fan inertia (for a lack of better word), the fan does *not* start.

That causes overheating!

If I gently push the fan or blow towards it, it starts spinning and 
BIOS/f71882fg takes over and controls it very well and it all works, 
until there comes a point again where the fan stops (outside temperature 
drops for example), in which case the whole cycle repeats.

I devised one ugly hack to fix this: I created a shell script, which 
runs every 10 seconds and checks to see if fanX_alarm=1 (this happens, 
for example, when there is current applied to the fan - i.e. its "pwmX" 
value is >0 and "fanX_input=0", i.e. the fan is not moving - the 
scenario I described above). If that is the case, then the script, 
temporarily, switches to "manual" control (pwmX_enable=1), throttles up 
the fan up to a maximum (i.e. pwmX%5), checks that the fan is running, 
and then restores automatic control (reverts pwmX_enable back to 2).

That way, when the fan is initially stopped and the BIOS/f71882fg driver 
applies some current to it in order to get it going and can't do it, it 
gets a gentle "push" from my script, after which automatic control takes 
over again and all is well.

That way it works, but I don't like it - there has to be another, more 
"civilised" way of doing this, surely!

One last question (though this is more specific to the f71882fg driver): 
I have a procfs file called "pwmX_auto_pointY" (Y being from 1-5), which 
indicates the various pwm current value which is to be applied for 
different points: 4 being when the controlling temperature is low (the 
value of pwmX_auto_point4_temp to be precise) and 1 being where the 
current is at its maximum - normally 255.

Now, what is the purpose of pwmX_auto_point5 - does this hold the pwm 
value where the fan is in an idle state (i.e. the temperature is below 
pwmX_auto_point4_temp)? Because on all 3 fans, I have this set to 1, 
which, I am assuming is when the fans are stopped.

Even if I bring this value to some "idle" current, that won't help much 
because when I first boot the system, the fans are *always* still, so 
even if the idle state is >1, that won't help me much, so there must be 
another - better - way than using a script to "kickstart" the fans 
initially, surely!

Apologies for this long post, but I have been banging my head against 
the wall with these problems for the past week with no end in sight!


MZ


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

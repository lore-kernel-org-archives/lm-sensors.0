From: Martin Herrman <martin.herrman@gmail.com>
Date: Sat, 18 Jan 2014 10:06:52 +0000
Subject: Re: [lm-sensors] Some questions from first user
Message-Id: <CADR1r6j+UnjEhfsxwy=66OxhhaS+vFJRMFyP1Oe4cN1dy_4V7A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
In-Reply-To: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014/1/16 Jean Delvare <khali@linux-fr.org>:

Hi Jean,

>> compute temp3 @+10,@+10
>
> Preferred way of doing this when the hardware supports it (and the
> IT8728F does) is:
>
>     set temp3_offset 10
>
> That being said I am not 100% positive that this works when the
> temperature sensor type is PECI. You'll have to try it out and see.

I have did some testing, but I'm not sure yet what to report. I don't
have a clear picture with repeatable results yet.

Offset values are by default not 0, does lm_sensors init script reset
offset values to default when removed from sensors.conf?, should I
compile sensor drivers as modules? (currently they are in the kernel,
so my init script fails when it tries to reload the modules),
sometimes I get negative values for _input when I switch from compute
to offset statement, why does compute +10 add 20 to reported values?

Actually, I think my most important question is: how does the compute
statement work?

>> (Note: I wonder if this is influenced by my BIOS settings, which
>> allows me to change the temperature for CPU warning.)
>
> It should indeed be. It's easy enough to try.

Answer after some testing: bios configuration defines the temp3_max value.

> It is possible that the board actually has two board sensors, even if
> the BIOS doesn't report both. As long as the values make sense and move
> in a realistic way, there is no reason to discard them.

I have put high load on both CPU and GPU, which automatically
increases case temp. Both temp1 and temp2 increase equally. So I
assume you are right, the board has 2 sensors but the bios only
reports 1.

>> I currently believe that my last two questions are:
>>
>> 10. How are temp1_min and temp1_max determined for the it8728 reportes
>> temperatures?
>
> They are arbitrary limits that can be set by the BIOS or the user. Min
> isn't so useful unless you live in Alaska or leave you system outside
> in winter. Max is more useful but only if some action is triggered by
> the alarm flag raising, either in the hardware or by software polling
> for the alarm flag.

As expected, thanks!

>> 11. What is temp1_type and temp1_offset?
>
> The sensor type (thermistor, thermal diode or digital aka PECI) and an
> offset that can be added by the hardware automatically, respectively.
>
> You normally don't have to change the sensor type as it should be set
> right by the BIOS. The type OTOH gives you a hint on what is what:
> board sensors are typically thermistors while CPU sensors are typically
> thermal diodes or PECI.
>
> Setting the offset attribute is equivalent to a simple compute formula,
> as stated above, and is more efficient as it is done by the hardware.
> It is also more convenient if you start playing with temperature-based
> fan speed control.

Thanks, this helps!

So I only have to figure out how to get the values right for temp3 and
the interaction between offset and compute values :-)

Regards,

Martin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

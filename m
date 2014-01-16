From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Jan 2014 22:08:14 +0000
Subject: Re: [lm-sensors] Some questions from first user
Message-Id: <20140116230814.344f8b98@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
In-Reply-To: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 16 Jan 2014 22:24:20 +0100, Martin Herrman wrote:
> 2014/1/9 Jean Delvare <khali@linux-fr.org>
> > PECI is the low level specification. Users wouldn't understand that
> > sensors returns negative, relative temperature values. So all drivers
> > supporting PECI compute the actual temperature based on the negative
> > PECI value and the base temperature (maximum temperature supported by
> > the component being monitored, the CPU in this case.) For some drivers
> > (such as it87) this is even done by the hardware itself. This assumes
> > that the base temperature is known and correct, which is unfortunately
> > not always the case. In the case of the IT8728F chip, the base
> > temperature should be set by the BIOS depending on your CPU model. The
> > fact that the values differ between coretemp and it87 suggests that the
> > BIOS and the coretemp driver disagree about the base temperature (which
> > matches temp1_crit for the coretemp driver.)
> 
> Clear again. coretemp _crit temperature is correct, so I have to
> adjust the IT8728F cpu temperature with 10 degrees:
> 
> compute temp3 @+10,@+10

Preferred way of doing this when the hardware supports it (and the
IT8728F does) is:

    set temp3_offset 10

That being said I am not 100% positive that this works when the
temperature sensor type is PECI. You'll have to try it out and see.

> (Note: I wonder if this is influenced by my BIOS settings, which
> allows me to change the temperature for CPU warning.)

It should indeed be. It's easy enough to try.

> > Check what the BIOS says, it typically shows two temperatures so that
> > should tell you what temp2 is. Check if the motherboard documentation
> > mentions anything. Then experiment by yourself (see what makes each
> > temperature rise the most.) It is possible that the 3rd temperature is
> > just noise.
> 
> Ok, a simple cpu load test showed that temp3 is the cpu temp. When I
> compare with the bios, I believe that temp1 is the system/case temp.
> In that case temp2 is the noise, but the difference between temp1 and
> temp2 is only about 3-4 degrees.
> 
> The user manual of my motherboard doesn't have much information about
> the temperature sensors.

It is possible that the board actually has two board sensors, even if
the BIOS doesn't report both. As long as the values make sense and move
in a realistic way, there is no reason to discard them.

> I currently believe that my last two questions are:
> 
> 10. How are temp1_min and temp1_max determined for the it8728 reportes
> temperatures?

They are arbitrary limits that can be set by the BIOS or the user. Min
isn't so useful unless you live in Alaska or leave you system outside
in winter. Max is more useful but only if some action is triggered by
the alarm flag raising, either in the hardware or by software polling
for the alarm flag.

> 11. What is temp1_type and temp1_offset?

The sensor type (thermistor, thermal diode or digital aka PECI) and an
offset that can be added by the hardware automatically, respectively.

You normally don't have to change the sensor type as it should be set
right by the BIOS. The type OTOH gives you a hint on what is what:
board sensors are typically thermistors while CPU sensors are typically
thermal diodes or PECI.

Setting the offset attribute is equivalent to a simple compute formula,
as stated above, and is more efficient as it is done by the hardware.
It is also more convenient if you start playing with temperature-based
fan speed control.

Hope that helps,
-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

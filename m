From: "Phil Endecott" <phil_lftzl_endecott@chezphil.org>
Date: Sun, 10 Jun 2007 23:56:45 +0000
Subject: Re: [lm-sensors] f71805f + J7F2;
Message-Id: <1181519805940@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609174408.170bfb85@hyperion.delvare>
In-Reply-To: <20070609174408.170bfb85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sat, 09 Jun 2007 18:40:06 +0100, Phil Endecott wrote:
>> It's clear that the right frequency to choose will depend on the 
>> particular hardware, but I don't think we'll find anything where 187 
>> kHz is a good choice.  It could perhaps be considered bizarre to choose 
>> a default based on what I found worked with my unique home-made 
>> hardware :-)  Jean, you must have written a script to get the numbers 
>> in that graph; if you post it, perhaps other people can try it out and 
>> we can see if there is a consensus?
>
> I published my script here:
> http://khali.linux-fr.org/devel/lm-sensors/draw_pwm_response.pl
> It writes the results to a CSV file, it's up to you to make a graph out
> of it (I think I used OOo calc).

Mine is here; I modified your script a bit: duty cycle increases on the 
X axis, it uses a different range of PWM frequencies, and I plotted it 
using gnuplot:

http://chezphil.org/tmp/fanplot.png

Based on this I think I'll reduce mine below 40 kHz, maybe 25 kHz or 
something like that.

>>                                     (The 'other people' don't need to 
>> be F71805 users since it's mainly measuring the characteristics of the 
>> fan itself.)
>
> This would be true if all the chips had perfectly square duty cycles at
> all frequencies, but you found out yourself that this isn't the case
> for the F71805F at high frequencies. Anyway, I suspect that fans are too
> different and we won't find a frequency which pleases everyone.

The effect we're seeing is due to the fan and the driver-transistors.  
All chips will have essentially identical outputs at their pins, which 
will look nice and square.

> I confirm that I didn't modify my board in any way, maybe it includes
> some additional circuitry. The problem isn't totally fixed though, as
> you can see on the graph, below 1000 RPMs I lose the fan speed readings
> (there were a couple bogus values which removed from the graph to make
> it clearer.) Is it even worst on your side?

Are you sure that it was a reading problem, not that the fan had 
actually stopped?  I could believe that fans have a minimum speed below 
which they don't have enough rotational momentum to get past the "dead 
points" in the magnetic field.

As you can see, my fan runs down to a few hundred RPM.  I haven't 
experimented further with that.

I will follow up on the other points over the next few days.  (Progress 
will be slower, I have other things to do during the week.)


Regards,

Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

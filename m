From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jun 2007 20:31:42 +0000
Subject: Re: [lm-sensors] f71805f + J7F2;
Message-Id: <20070612223142.67125e40@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070609174408.170bfb85@hyperion.delvare>
In-Reply-To: <20070609174408.170bfb85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Mon, 11 Jun 2007 00:56:45 +0100, Phil Endecott wrote:
> Jean Delvare wrote:
> > I published my script here:
> > http://khali.linux-fr.org/devel/lm-sensors/draw_pwm_response.pl
> > It writes the results to a CSV file, it's up to you to make a graph out
> > of it (I think I used OOo calc).
> 
> Mine is here; I modified your script a bit: duty cycle increases on the 
> X axis, it uses a different range of PWM frequencies, and I plotted it 
> using gnuplot:
> 
> http://chezphil.org/tmp/fanplot.png
> 
> Based on this I think I'll reduce mine below 40 kHz, maybe 25 kHz or 
> something like that.

You graph looks good, you fan seems to be better than mine. Admittedly,
this is a rather old 80 mm fan which I nailed on top of my CPU heatsink
just because it was relatively silent, compared to everything I bought
since then. It didn't originally meant to control its speed.

I agree that my X axis is in the wrong direction and that's somewhat
confusing. I did it that way because it's easier (and safer) to sample
the speeds while the PWM duty cycle decreases rather than increases -
but I should have reversed the array of values before drawing the graph.

> > I confirm that I didn't modify my board in any way, maybe it includes
> > some additional circuitry. The problem isn't totally fixed though, as
> > you can see on the graph, below 1000 RPMs I lose the fan speed readings
> > (there were a couple bogus values which removed from the graph to make
> > it clearer.) Is it even worst on your side?
> 
> Are you sure that it was a reading problem, not that the fan had 
> actually stopped?  I could believe that fans have a minimum speed below 
> which they don't have enough rotational momentum to get past the "dead 
> points" in the magnetic field.
> 
> As you can see, my fan runs down to a few hundred RPM.  I haven't 
> experimented further with that.

This was one part of the effect I observed back then, and my graph
shows it for low frequencies: the fan stops way before the 0% duty
cycle. But on top of that, before the full stop, some values were
obviously bogus: I could see the fan spin relatively slowly as
expected, but the driver was telling me speeds like 3000 RPM - more
than this fan can actually do. So I think that artifacts were confusing
the tachometer somehow. This is something to remember, because when
this happens, this means that the given frequency isn't suitable for
automatic fan speed control.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

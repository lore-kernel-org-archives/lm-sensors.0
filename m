From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <MPstw26D.1115728134.8035030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Yes, so the Winbond drivers (at least w82627hf) do not report pin
> voltage for 5V and 5VSB thus need this or similar fix.

Seems that you're correct there. Looking at my pc87360 driver, it has
the same problem (in7, in8 and in10 are internally scaled, yet the
scaling is done by libsensors).

Now, as to whether this should be fixed, depends on how much complexity
it adds to the drivers. Also note that this will cause trouble to the
users (which will have to remove compute lines from /etc/sensors.conf).

> > Your code makes sense for external resistors, but not for internal
> > scaling as far as I can see, so it won't be of any help in the drivers.
>
> Okay another exception for Winbond chips.

Correct. First time I see this usually internal scaling is about
normalized values, not resistor ratios.

> The benefit of doing resistor based scaling is that resistor value
> are in a discrete value series so one may pick an unambiguous pair
> for a particular positive or negative voltage reading.  A user-space
> program can take observed reading (BIOS or measured) and produce
> 'best match' pair that works, as mobo maker using same discrete
> value series.

Feel free to distribute such a user-space tool, so you'll see how useful
people find it. I am quite suspicious about the fact that it'll work
for all motherboards. Not all voltage inputs might use two resistors for
scaling (think inverting amps, amps, reference voltages...). There are
also many different measured voltages (Vcore, Vram, Vagp, +1.5, +3.3,
+5, +12, -12, -5, battery...) some of which change depending on the
system. Depending on the ADC, some may need scaling or not (e.g. +3.3
needs scaling on the PC87366). I think you'll have a very hard time
writing a tool dealing with all the cases.

> You did ask me once how to do scaling without reciprocal formula
> entry?  This is one way how.  It doesn't have to go into driver,
> though perhaps partially, to meet self-scaled input requirements.

Only works for voltages. They are the main user of compute lines for
sure, but not the only ones. For this reason, I'd prefer your tool to
generate the compute lines rather than modifying libsensors to handle a
different syntax.

Maybe a simple document would even be just as useful.

> I started on this originally because I could find no documentation on
> which adm9240 VccpX input was monitoring respective -5 and -12 volt
> inputs on Intel SE440BX-2 mobo -- what surprised me back then was the
> totally unambiguous answer the method of using resistor series values
> gave.  Not only told me resistor values, it unambiguously told me which
> sensor input was measuring which negative voltage.  I think I posted
> that here a while ago.

You did. It worked for you, great, but you knew what you were after, and
had only two missing inputs. The general case is much more complex than
that.

> libsensors cannot compute negative voltages for adm9240 as they require
> two inputs for the calculation?  You not corrected that notion for me,
> did I miss some thing in compute syntax or it simply isn't there?

Compute lines can refer to input values, e.g.:

  compute in5  (@ - in3) * 2, @ / 2 + in3

Isn't it what you need? Just make sure that compute lines are in the
right order (I think it matters).

> Sensors needs a cleanup, and it seems right at the core parser, that's
> not a nice one to take on, but from end-user point of view it needs
> doing.  One day :)  The lex/yacc parser in sensors is not terribly
> bright, I've forgotten if there is more modern way to build a parser,
> but the core parser doesn't look right, although its been a few years
> since I did one ('97 or '98), I'd have to dig it up and look.

Totally agree with you here, the parser is very hard to maintain, lex and
yacc aren't my friends. And it leaks memory...

But rather than trying to fix that broken libsensors, writing a new one
would be more useful IMHO (but this requires finishing the sysfs
interface as I said before).

--
Jean Delvare

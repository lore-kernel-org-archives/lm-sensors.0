From: floyd@barrow.com (Floyd L. Davidson)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: tellerstats shell scripts from lm_sensors
Message-Id: <87pt4u8lbh.fld@barrow.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4140888C.4060806@edgedesign.us>
In-Reply-To: <4140888C.4060806@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"Jean Delvare" <khali@linux-fr.org> wrote:
>Floyd L. Davidson wrote:
>> I've been playing with the scripts from tellerstats (version
>> 1.9.2, according to the README me file) distributed with
>> lm_sensors.  In particular, I have a Linux based system running
>> on a Tyan S2462 motherboard with dual AMD Athlon CPUs.
>> (...)
>> differences.  An example of the graphs generated can be seen
>> at
>>
>>     http://web.newsguy.com/floyd_davidson/stats/index.html
>>
>
>As a side note, it looks like you are using high fan clock divider values.
>With such high speed fans you should not need to do so. You could try lowering
>the fanN_div values to obtain nicer fan speed graphs (i.e. with smaller steps.)

Hi Jean, thank you for the interest.  A few comments on this
particular topic, and then I've got a different topic for you.

I'm not sure smaller steps makes for "nicer" graphs! :-)

I'm most interested in having a graph that is instantly
indicative of the health of the fan.  Fans don't usually just
die and stop running.  Instead the bearings slowly go bad, and
it starts with intermittent slowing down.  Hence I do want good
resolution at lower speeds... and large steps that make it
obvious something is happening when it starts slowing down.

However, to make apparently "smaller steps" on the graph it
would probably be better to extend the graph range.  I'm using a
pretty small range, from 6000 to 8500, which tends to make the
variations look huge.  A graph range of say 0 to 10000 does make
that a little less distracting.

Plus there are relatively no real problems with using higher
divisors, but there are definite problems from using lower ones,
e.g., with slow speed fans.  Hence while a particular individual
might well use lower divisors with high speed fans, an example
program probably should stick with the highest divisor, 8.

I've just changed gnuplotscript.html first to a 0-9k range,
and then to a 0-10k range.  I kinda like that last one, so
I'll probably upload that revision and a new set of images.

Note also that previously today I uploaded a new set of example
graphs and a new version of gnuplotscript.tmpl to generate them.
A number of minor and a couple of major changes.  The
temperature plots are now banded with different colors depending
on the temperatures being plotted.  At first I had 5 colors, but
then decided it wasn't better than just 3 and uploaded another
set.  Cool temps are blue, then it turns to magenta, and if it
gets up close the "maximum" line, it turns to red.


On to a second topic.  If I remember right you are the one who
took interest in the lm_sensors tickets on problems accessing
the Hardware Monitor section of the W83627HF Super IO chip on
some of the Tyan motherboards (that was a year or two past, and
some of the ticket numbers are 729, 764, 808, 861, and 867 and
941 among others).  There was some asm code (861) and C code
(867) posted that, while somewhat buggy, will enable the
W83627HF's hardware sensors.  But nobody dug into it far enough
to really answer all the questions, and the code presented isn't
something that non-programmers would want to use.

I just spent a bit of time experimenting to figure out as much
as I could about what is going on, and wrote a more universal
program to enable and initialize the W83627HF sensors.  It works
on the S2462 motherboard and would probably work on other Tyan
boards.

The program is on my web page at

  http://web.newsguy.com/floyd_davidson/sensors/

  Have a good day,
  Floyd

-- 
Floyd L. Davidson           <http://web.newsguy.com/floyd_davidson>
Ukpeagvik "Place where people hunt snowy owls"     (Barrow, Alaska)

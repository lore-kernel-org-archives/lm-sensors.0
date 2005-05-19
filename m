From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: tellerstats shell scripts from lm_sensors
Message-Id: <20040910105207.M34735@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4140888C.4060806@edgedesign.us>
In-Reply-To: <4140888C.4060806@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Sep 2004 02:33:54 -0800, Floyd L. Davidson wrote
> I'm not sure smaller steps makes for "nicer" graphs! :-)

Oh well, that's a matter of personal taste I guess ;)

> I'm most interested in having a graph that is instantly
> indicative of the health of the fan.  Fans don't usually just
> die and stop running.  Instead the bearings slowly go bad, and
> it starts with intermittent slowing down.  Hence I do want good
> resolution at lower speeds... and large steps that make it
> obvious something is happening when it starts slowing down.
> 
> However, to make apparently "smaller steps" on the graph it
> would probably be better to extend the graph range.  I'm using a
> pretty small range, from 6000 to 8500, which tends to make the
> variations look huge.  A graph range of say 0 to 10000 does make
> that a little less distracting.

That's pretty much what I meant. Limiting the graph to a high range meant that
you wouldn't have been able to display lower speeds, so it was kind of
pointless to set the dividers to a value that would allow them to be measured.

> Plus there are relatively no real problems with using higher
> divisors, but there are definite problems from using lower ones,
> e.g., with slow speed fans.  Hence while a particular individual
> might well use lower divisors with high speed fans, an example
> program probably should stick with the highest divisor, 8.

As a side note, 8 is not the highest divider for all chips. Some go up to 128.
However I agree that starting with a high divider makes sense. Note that I
have plans to automate the divider selection. This is already in place in the
pc87360 driver and should probably be extended to other drivers (although this
isn't trivial and discussions have occured about the topic).

My comment was for your specific case. Since you obviously have high speed
fans and consider that they shouldn't drop below 6000RPM, setting low dividers
would make sense. The fact that you then cannot get the exact reading when the
fan drops below 2500RPM is probably not a problem. 2500RPM is not
fundamentally different from a stopped fan if the nominal speed is 7000RPM. In
both cases you better hurry up and get it fixed.

So that's what I would so - but you are of course free to follow a different
approach. Your (new) approach is perfectly valid too.

> On to a second topic.  If I remember right you are the one who
> took interest in the lm_sensors tickets on problems accessing
> the Hardware Monitor section of the W83627HF Super IO chip on
> some of the Tyan motherboards (that was a year or two past, and
> some of the ticket numbers are 729, 764, 808, 861, and 867 and
> 941 among others).  There was some asm code (861) and C code
> (867) posted that, while somewhat buggy, will enable the
> W83627HF's hardware sensors.  But nobody dug into it far enough
> to really answer all the questions, and the code presented isn't
> something that non-programmers would want to use.

I am not the one. Back then I was not very active in the project (if I only
were active at all). Mark D. Studebaker did answer the tickets, it seems.

> I just spent a bit of time experimenting to figure out as much
> as I could about what is going on, and wrote a more universal
> program to enable and initialize the W83627HF sensors.  It works
> on the S2462 motherboard and would probably work on other Tyan
> boards.
> 
> The program is on my web page at
> 
>   http://web.newsguy.com/floyd_davidson/sensors/

404 Not Found

At any rate, the prefered form for inclusions in the lm_sensors package are
small, targeted patches to our tree. This is true for your work on tellerstats
as well. Individual patches can be quickly reviewed if done properly. And it
happens that none of us seems to have much spare time these days.

A different approach is that you can keep your work on your own web pages and
we simply link to them (from our "useful links" page). You choose.

-- 
Jean Delvare
http://khali.linux-fr.org/

From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <lf5281p2mcj371rj5a5bhcpac1rbmm5ge9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 10 May 2005 14:28:54 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>> Yes, so the Winbond drivers (at least w82627hf) do not report pin
>> voltage for 5V and 5VSB thus need this or similar fix.
>
>Seems that you're correct there. Looking at my pc87360 driver, it has
>the same problem (in7, in8 and in10 are internally scaled, yet the
>scaling is done by libsensors).
>
>Now, as to whether this should be fixed, depends on how much complexity
>it adds to the drivers. Also note that this will cause trouble to the
>users (which will have to remove compute lines from /etc/sensors.conf).

Depends how far you want to go, normalised fullscale mV lookup is 
simple, just a static lookup array of u16.  I suspect static lookups 
are cheaper than 'fancy code'.

Full-blown scaling needs r/w accessors to private memory values 
and a normalised resistor ratio, not much, but seems against policy.

This is why I'm discussing, not coding.  Right now we are is a mixed 
state, one could just as easily argue all scaling done in user space.

This mix of half + half is confusing, inconsistent and difficult to 
resolve.  Yes.  Having the _option_ of driver based scaling lets us 
have it both ways, default to existing system, offer optional scaling 
for new stuff, I'd like to do it like this as it doesn't break 
libsensors, but _does_ allow drivers to work independently, thus avoid 
having to keep two systems in step. 
>
>> Okay another exception for Winbond chips.
>
>Correct. First time I see this usually internal scaling is about
>normalized values, not resistor ratios.

Yes, but I think scaling should be traceable to data sheet expression 
of scaling method is good, so I worked out how to do that in fixed 
point.  I've done winbond the other way too, 'faking' the effective 
fullscale measurement range for Winbond:  5V -> 6881mV fullscale, and 
5VSB is 6205mV fullscale.  Trouble is, you end up with a u16 array 
lookup of mostly 4096mV values, it looked silly :)

Perhaps my pair of u8 resistor arrays looked just as silly to you?

I did it that way so values traceable to datasheet, it is also very 
close to full-blown scaling in driver at small cost of placing 
arrays in memory, and r/w accessors for changeable inputs (non-
changeable could be r/o accessor as place holder)

>Feel free to distribute such a user-space tool, so you'll see how useful
>people find it. I am quite suspicious about the fact that it'll work
>for all motherboards. Not all voltage inputs might use two resistors for
>scaling (think inverting amps, amps, reference voltages...). There are
>also many different measured voltages (Vcore, Vram, Vagp, +1.5, +3.3,
>+5, +12, -12, -5, battery...) some of which change depending on the
>system. Depending on the ADC, some may need scaling or not (e.g. +3.3
>needs scaling on the PC87366). I think you'll have a very hard time
>writing a tool dealing with all the cases.

Well yes, I'm only addressing one issue, mobo makers changing external 
divider resistors, and a reliable method to account for that one aspect.

Not replacing the whole thing :)

Example, I installed msft win on new machine to get second opinion 
on fan control (They can't do it either), and the 5VSB was reported 
as 5.5V --> I know why now: they used 34/50 instead of 17/33 for 
5VSB.  Didn't read datasheet...  

That the simple task I wanted to address: mobo make used different 
resistor divider to manuf. recommended, how to discover?  It works 
for that one purpose I wanted, and works well.  I'm not suggesting 
it has any use beyond that, certainly not as a replacement for 
existing code, just one way to resolve a particular problem, the 
new idea here is using the typical discrete resistor value series 
to discover viable ratios.

>Only works for voltages. They are the main user of compute lines for
>sure, but not the only ones. For this reason, I'd prefer your tool to
>generate the compute lines rather than modifying libsensors to handle a
>different syntax.

Oh sure, as I get to know the system I can see libsensors can do the 
job, not even a different syntax (I don't think), more below...

So yes, once we discover resistor ratio it can go straight in to 
libsensors syntax compute line, no problem.  
>
>Maybe a simple document would even be just as useful.

Yes, I'm working up to that, a document and a small program/script 
that takes observed readings and produces likely resistor ratios 
leading to compute lines for libsensors is end result.  This is 
aimed squarely at +12, -5 and -12 readings, nothing more.

What surprised me was it tells me quite accurately the required 
resistor ratios, yes it addresses this one aspect, but isn't that 
often requested?  Why are mobo readings so different BIOS vs sensors?

>Compute lines can refer to input values, e.g.:
>
>  compute in5  (@ - in3) * 2, @ / 2 + in3
>
>Isn't it what you need? Just make sure that compute lines are in the
>right order (I think it matters).

Thanks, I didn't pick that up from documentation, but it was long 
time ago I looked.  Yes, it is what I needed :)

for adm9240:

in5 is -12V, in3 is 5V

-12V indicated = 
current through R1		(in - 5V) / R1
multiplied by R2		(in - 5V) * R2 / R1
offset by voltage at top of R2	((in - 5V) * R2 / R1) + in

compute in5 ((@ - in3) * 82 / 15) + @, ??

A similar formula is required for winbond, except they provide 
a 3600mV reference to drive top of voltage divider.

Winbond -12V with datasheet resistors:

compute in5 ((@ - 3600) * 232 / 56) + @, ??

I never did get around to working out the reciprocal for those :)

But you can clearly see that the winbond negative voltage example 
in sensors.conf is wrong because it doesn't offset the reading? 
Instead, it fudges the multiplier, not correct at all.

These are straight line transforms: y = mx + c, c is zero for positive 
voltages, but not for negative voltages.

>> Sensors needs a cleanup, and it seems right at the core parser, that's
>> not a nice one to take on, but from end-user point of view it needs
>> doing.  One day :)  The lex/yacc parser in sensors is not terribly
>> bright, I've forgotten if there is more modern way to build a parser,
>> but the core parser doesn't look right, although its been a few years
>> since I did one ('97 or '98), I'd have to dig it up and look.
>
>Totally agree with you here, the parser is very hard to maintain, lex and
>yacc aren't my friends. And it leaks memory...

Doesn't surprise me :)  Peculiar way of thinking required for 
defining a formal grammar.  
>
>But rather than trying to fix that broken libsensors, writing a new one
>would be more useful IMHO (but this requires finishing the sysfs
>interface as I said before).

For a while there I wasn't sure if Yani's work was going to change 
sysfs names, I didn't get a reply on 'faking' fan_div for fscher, 
perhaps it is better to do fanX_ppr and reflect chip function?

I don't want to rewrite libsensors, I'd like to sidestep it though :o)

Banging against the boundaries again...

--Grant.

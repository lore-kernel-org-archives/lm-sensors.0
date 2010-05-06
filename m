From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 May 2010 12:20:56 +0000
Subject: Re: [lm-sensors] 3.1.2 sensord duplicate RRD name problem
Message-Id: <20100506142056.0a46953f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
In-Reply-To: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Sergey and Andre,

On Thu, 6 May 2010 10:34:42 +0200, Jean Delvare wrote:
> Hi Sergei,
> 
> On Thu, 4 Mar 2010 14:37:05 +0200, Sergey Kvachonok wrote:
> > sensord fails to start with the following messages:
> > 
> > sensord: Creating round robin database
> > sensord: Error creating RRD file: /var/log/sensord.rrd: Duplicate DS name: temp1
> > 
> > sensors output is like this:
> > 
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +26.0 C  (high = +76.0 C, crit = +100.0 C)
> > 
> > coretemp-isa-0001
> > Adapter: ISA adapter
> > Core 1:      +27.0 C  (high = +76.0 C, crit = +100.0 C)
> > 
> > it8718-isa-0290
> > Adapter: ISA adapter
> > Vcore:       +1.01 V  (min =  +0.00 V, max =  +4.08 V)
> > V_DDR2:      +1.90 V  (min =  +0.00 V, max =  +4.08 V)
> > +3.3V:       +3.38 V  (min =  +0.00 V, max =  +4.08 V)
> > in3:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
> > in4:         +0.38 V  (min =  +0.00 V, max =  +2.10 V)
> > in7:         +3.15 V  (min =  +0.00 V, max =  +4.08 V)
> > Vbat:        +3.18 V
> > CPU fan:     148 RPM  (min =   10 RPM)
> > System fan:    0 RPM  (min =    0 RPM)
> > temp1:       -55.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> > temp2:        -2.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> > MB temp:     +17.0 C  (low  = +127.0 C, high = +60.0 C)  sensor = thermal diode
> > cpu0_vid:   +3.300 V
> > 
> > I believe the problem is that different sensors provide results with
> > the same name 'temp1'.
> > Are there any solutions for this problem?
> 
> Thanks for reporting. this appears to be a regression in 3.1.2, as I am
> able to reproduce the bug with this version but not with 3.1.1 on the
> same machine.
> 
> Andre, a bisection points to the following change of yours:
> http://www.lm-sensors.org/changeset/5792/lm-sensors/trunk/prog/sensord
> Any idea?

I think I see what's going on. Andre's patch assumes that the feature
number and the label slot number are always the sync, while feature
numbers are per-chip values and label slot numbers are global. It
doesn't make a difference when there's a single monitoring chip on the
system (or sensord is run on a single chip on purpose, as I always do)
but it breaks as soon as there is more than one chip handled by sensord.

As usual the use of global variables make the code much harder to
understand, which certainly explains why I didn't see the bug when
reviewing the patch.

I've created a ticket to track this bug:
http://www.lm-sensors.org/ticket/2377

Andre, I remember commenting on exactly this on the first version of
your patch:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-June/026172.html

Quoting myself:
"As far as I can see, 'i' and 'num' have the same value throughout the
loop, so you might as well get rid of one of them."

I think my comment was correct given the code, but instead of just
simplifying the code as we finally did, we should have asked ourselves
why such a simplification was suddenly possible with your patch if it
was not beforehand. In fact your first patch was already wrong, because
you reset num to 0 at the wrong place.

I have a patch ready, I'll give it some testing to make sure I got it
right, and then I'll post it here.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

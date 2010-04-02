From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Apr 2010 17:11:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4245) Read GPIO registers
Message-Id: <20100402191124.0c6d440d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330225704.GF20635@ovro.caltech.edu>
In-Reply-To: <20100330225704.GF20635@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Fri, 2 Apr 2010 09:45:07 -0700, Ira W. Snyder wrote:
> On Fri, Apr 02, 2010 at 06:24:38PM +0200, Jean Delvare wrote:
> > You wired your chip in a way it was not meant to be. You shouldn't have.
> 
> Why do you think it is wired incorrectly?

Just look at the code you had to write to get it to work... (And it's
not even covering all use cases, see below.)

> Nothing I've found in the
> datasheet suggests that. If you can provide some insight into why you
> think this is, maybe we can come to an agreement, instead of just making
> me very frustrated.
> 
> On Page 24, "General Purpose Input/Outputs", the text says that any of
> the three GPIO pins can be connected to the ADC. Page 32, Table 13 "GPIO
> Register G" supports this. Each of the three GPIO pins has exactly the
> same configurable settings as all the others.
> 
> Page 13 "Configuration, GPIO, and Precharge" also states: The GPIO1 to
> GPIO3 pins can be used as general purpose inputs or outputs. One of the
> pins can also be multiplexed to the GPIO channel of the ADC.
> 
> The way I read this, it means: only one of the pins can be multiplexed
> onto the ADC ***at a single moment in time***.

The way I read this, it means: you get to choose one GPIO pin to be
routed to the ADC, by configuring register G at initialization time. Of
course nothing prevents you from changing configuration settings later,
but same holds for every other configuration bit, still most of them
make no sense changing after initialization.

> Why else would the GPIO
> register (0x6) exist, other than to let the user switch between them at
> runtime?

Maybe to give some flexibility with wire routing on the board. Or
because GPIO1 has extra features (so that wouldn't be the best choice
for routing to ADC) but GPIO2 and 3 aren't available on the UHF part, so
there was no one-fits-all decision. Or maybe just for maketing, 'cause
now they can claim the part lets you monitor N+2 voltages, so it looks
very cool.

> This kind of design sucks, but it is common in the embedded
> world, where we are always trying to use fewer parts to do the same job.

Of course, it is possible to change the GPIO routing to ADC at
run-time. But then you get a reading for each every 3 refresh cycles.
You say it means every 3 seconds, but you can get much older results if
you do not read the values every second. Someone running "sensors"
manually at a given point in time to get the current state of the
system would end up seeing 2 values which might be hours or days old,
or even zero values if it is the first use since the driver was loaded.
This is very confusing and I certainly don't want any of our drivers to
behave that way.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

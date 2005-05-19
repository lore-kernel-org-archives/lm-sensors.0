From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Question about VID
Message-Id: <3FA6797C.8060509@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031031055903.GB20640@earth.solarsys.private>
In-Reply-To: <20031031055903.GB20640@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is something like this in the ADM1026 driver.

The pins are actually GPIO, but the data sheet shows them "typically" 
connected as VID.  So the driver makes a "rash" assumption that they are 
connected as suggested on the datasheet.

But I did two other things.  I allowed the VID value to be *written* to 
override the assumed value, and I export the GPIO pins raw as "gpio" so 
that an expression in sensors.conf can set the vid value from the gpio 
value by bitsifts (multiply and divide by 2) and masking.

:v)

Mark Studebaker wrote:

> just assume the vid pins are always there.
> If they aren't hooked up, it's no different than for any
> other chip or driver.
> vid is only used for calculation of limits in sensors.conf.
> how many people bother to program the correct "VRM" specification
> setting anyway, I don't know, probably isn't that high...
>
> Mark M. Hoffman wrote:
>
>> Hello everyone:
>>
>> Looks like w83627thf doesn't have dedicated VID pins.  But, it has a
>> few GPIO pins... some of which just happen to be the same pin #s as
>> the dedicated VID pins on the w83627hf.  Haven't tried it yet, but I'd
>> bet money that's how it's wired too.  Any clever ideas about how to
>> support something like that in the driver?  I'm thinking of just using
>> some #ifdef's, but that's not very clever.
>>
>> Regards,
>>
>
>


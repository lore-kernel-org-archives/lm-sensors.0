From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 31 Oct 2011 21:27:31 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Add support for the
Message-Id: <1320096451.18747.59.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031152342.15f99729@endymion.delvare>
In-Reply-To: <20111031152342.15f99729@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, 2011-10-31 at 17:03 -0400, Jean Delvare wrote:
> On Mon, 31 Oct 2011 08:45:52 -0700, Guenter Roeck wrote:
> > Not sure if moving NCT677[56] to a separate driver would make much of a
> > difference in the complexity of this one.
> 
> The W83627UHG is clearly on the side of the W83627DHG. The decision of
> splitting NCT677[56] support to a separate driver is unrelated IMHO.
> The rationale is that the w83627ehf driver code has become quite
> complex (it's the 3rd hwmon driver by size out of 117!) and a lot of the
> code recently added only applies to the NCT677[56]. If future devices
> are almost compatible with the NCT677[56] but not quite, things will
> only become worse.
> 
There is at least one new Nuvoton chip which is completely microcode
programmed (NCT6681D). Nuvoton advertises it as "the first IC of
Nuvoton`s new product line, or eSIO". Not entirely sure what that means,
but it almost looks like we may have reached the end of the hard-core
LPC devices.

Two other currently not supported chips are NCT5577D, which seems to be
a variant of NCT677[56]F, and W83527HG, which seems to be somewhere in
between NCT6775F and earlier chips.

> With separate drivers, the code would become easier to read IMHO.
> Obviously this implies some code duplication but I believe we reached
> the point where this should be considered. Another benefit is that we
> could then have separate maintainers for the two drivers, so better
> load balancing.
> 
Agreed.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

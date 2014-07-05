From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 05 Jul 2014 08:53:28 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm9240) Avoid forward declaration
Message-Id: <20140705105328.55f0c50f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395989.4895.12.camel@phoenix>
In-Reply-To: <1404395989.4895.12.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 04 Jul 2014 18:01:25 -0700, Guenter Roeck wrote:
> On 07/04/2014 01:20 PM, Jean Delvare wrote:
> > Not just "this is a bank register". You also most specify which bits
> > set the bank number (which in turn define the maximum number of banks),
> > and the range of banked registers.
> >
> > I did not think about it in depth yet, but there are two options that
> > come to my mind: module parameters indeed, or sysfs attributes. We
> > could create a sysfs directory for every client address and have
> > writable attributes bank_reg, bank_mask, banked_start_reg and
> > banked_end_reg in that directory. Not sure exactly where actually,
> > maybe we would need to introduce a virtual i2c-stub device, or use
> > debugfs.
> >
> > Module parameters would work too, that's probably easier to implement
> > that way, but that's also less flexible, as you have to setup
> > everything upon module loading. That might be just fine though, as
> > being able to change the bank setup at run-time has little practical
> > value IMHO.
> 
> At least with my module test scripts, I re-load the i2c-stub driver
> before testing a new chip, to make sure that its state is 'clean'.
> So module parameters work just fine for me.

I started working on the idea using module parameters. A lot more work
is needed though, and I have a lot of other things to do today.

> Could we use a single module parameter ?
> 
> bank_reg=<reg> <mask>

What would be the benefit? Using parameters with single integer values
is simple. Using space-separated lists would require us to parse the
parameters ourselves.

> would probably do for a start, and mask could even be optional.

I don't think we can make the mask optional. For one thing, that would
force us to allocate memory for all 256 possible banks, which would be
a waste of memory. For another, it would make a single bank appear as
separate ones, so changes to one of the bank "copies" would not reflect
in the other "copies". Winbond for example uses the MSB of the register
bank to select the low or high byte of the vendor ID.

> Not sure
> if banked_start_reg and banked_end_reg are necessary. If so the above
> could be extended to
> 
> bank_reg=<reg> <mask> <start> <end>

I think we have to, for mostly the same reason we need to limit the
number of banks: non-banked registers are shared between banks. If we
don't specify the range of banked registers, changes done to shared
registers won't reflect between banks, and that will confuse the
drivers.

One thing I'm not yet sure of is if we want to handle banks on more
than one chip at a time. I started coding that way but it might be
somewhat overkill actually. I guess you won't need that for your
testing.

> That would not work for PMBus chips - those are so complex that
> it is unlikely we'll ever be able to simulate one without much
> more complexity - it would require the ability to return a failure
> when trying to access unsupported registers/commands, and that
> on each of the pages.

PMBus chips are a breed on their own. I don't think the generic
i2c-stub driver will ever be enough for these. You'd need a dedicated
emulator for them.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

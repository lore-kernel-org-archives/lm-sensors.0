From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Apr 2010 16:24:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4245) Read GPIO registers
Message-Id: <20100402182438.6d1d67f0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330225704.GF20635@ovro.caltech.edu>
In-Reply-To: <20100330225704.GF20635@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2 Apr 2010 09:12:59 -0700, Ira W. Snyder wrote:
> On Fri, Apr 02, 2010 at 10:13:41AM +0200, Jean Delvare wrote:
> > Hi Ira,
> > 
> > On Tue, 30 Mar 2010 15:57:04 -0700, Ira W. Snyder wrote:
> > > The GPIO registers on the ltc4245 behave in a strage way. Every time the
> > > ADC updates the values for one GPIO, it updates all three GPIO registers to
> > > the same value.
> > 
> > This is not how I read the datasheet. The datasheet says that only one
> > of the GPIO pins can be routed to the 13th input of the ADC and thus
> > used as an extra analog voltage input. It also says that there is ONE
> > register (U) holding the result of the conversion. Apparently many
> > registers can be access using more than one address, and register U can
> > be accessed using 4 different addresses (0x1c, 0x1d, 0x1e, 0x1f) but
> > this is still only one register. So the fact that all addresses return
> > the same value is not a surprise.
> > 
> 
> Ok, re-reading tables 6 and 15 in the datasheet, this makes sense now.
> 
> > > To read all three GPIO registers correctly, we cache copies of each
> > > register and update the GPIO MUX to read the next GPIO register. Each GPIO
> > > sample will take 3 * HZ to read, but at least we are returning the correct
> > > values to userspace.
> > 
> > I think this is wrong. You should not expose 3 values to user-space,
> > you should only expose one. The two other GPIOs are supposed to be used
> > in digital mode. It's not even clear to me that you should always expose
> > it, as the application may be using all 3 GPIO pins in digital mode and
> > not be interested in sampling an analog voltage value from any of them.
> > I admit I am a little surprised that there is no way to disable ADC
> > operation on the GPIO pin.
> > 
> 
> If I do this, how do I make userspace work?
> 
> On my board, I have three different devices hooked up to the three GPIO
> pins. They're all analog voltages. From userspace, I currently read
> in{9,10,11}_input and report those in volts. It works fine, and was
> pretty easy to implement.
> 
> If I only report a single GPIO value to userspace, then I can only read
> one device. How do I switch which GPIO pin is routed to the ADC? I could
> open the /dev/i2c-0 device and poke the LTC4245_CONTROL register
> directly, but that seems very anti-hwmon, doesn't it?

You wired your chip in a way it was not meant to be. You shouldn't have.

> 
> > > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > > ---
> > > 
> > > When I implemented the ltc4245 driver, I did not have the ability to test
> > > the GPIO pins. I now have devices hooked up, and they don't work exactly as
> > > the datasheet describes (though it is vague in this section). See the patch
> > > description for more detail.
> > 
> > I think it does behave as the datasheet describes, I'm not sure what
> > you think is vague, it looks clear to me.
> > 
> > > I'd really like to see this picked up. I hunch I am the only user of the
> > > driver, or others would have complained. :) I wish the code wasn't as ugly
> > > as it is, but it is the best I can come up with.
> > 
> > I agree the driver is broken currently, but I don't agree with the
> > proposed fix. Please just drop the LTC4245_GPIOADC2 and
> > LTC4245_GPIOADC3 commands, which do not exist, and rename
> > LTC4245_GPIOADC1 to LTC4245_GPIOADC.
> > 
> 
> Ok, so I should use LTC4245_GPIOADC (0x1c) to read all of the GPIO
> values. That seems fine to me, I can implement that.
> 
> See above about how to report this to userspace. I don't know how you
> want this exposed in sysfs.

I don't want it exposed at all.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

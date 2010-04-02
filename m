From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Apr 2010 08:13:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4245) Read GPIO registers
Message-Id: <20100402101341.05f63bc7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100330225704.GF20635@ovro.caltech.edu>
In-Reply-To: <20100330225704.GF20635@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Tue, 30 Mar 2010 15:57:04 -0700, Ira W. Snyder wrote:
> The GPIO registers on the ltc4245 behave in a strage way. Every time the
> ADC updates the values for one GPIO, it updates all three GPIO registers to
> the same value.

This is not how I read the datasheet. The datasheet says that only one
of the GPIO pins can be routed to the 13th input of the ADC and thus
used as an extra analog voltage input. It also says that there is ONE
register (U) holding the result of the conversion. Apparently many
registers can be access using more than one address, and register U can
be accessed using 4 different addresses (0x1c, 0x1d, 0x1e, 0x1f) but
this is still only one register. So the fact that all addresses return
the same value is not a surprise.

> To read all three GPIO registers correctly, we cache copies of each
> register and update the GPIO MUX to read the next GPIO register. Each GPIO
> sample will take 3 * HZ to read, but at least we are returning the correct
> values to userspace.

I think this is wrong. You should not expose 3 values to user-space,
you should only expose one. The two other GPIOs are supposed to be used
in digital mode. It's not even clear to me that you should always expose
it, as the application may be using all 3 GPIO pins in digital mode and
not be interested in sampling an analog voltage value from any of them.
I admit I am a little surprised that there is no way to disable ADC
operation on the GPIO pin.

> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> When I implemented the ltc4245 driver, I did not have the ability to test
> the GPIO pins. I now have devices hooked up, and they don't work exactly as
> the datasheet describes (though it is vague in this section). See the patch
> description for more detail.

I think it does behave as the datasheet describes, I'm not sure what
you think is vague, it looks clear to me.

> I'd really like to see this picked up. I hunch I am the only user of the
> driver, or others would have complained. :) I wish the code wasn't as ugly
> as it is, but it is the best I can come up with.

I agree the driver is broken currently, but I don't agree with the
proposed fix. Please just drop the LTC4245_GPIOADC2 and
LTC4245_GPIOADC3 commands, which do not exist, and rename
LTC4245_GPIOADC1 to LTC4245_GPIOADC.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

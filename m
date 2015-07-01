From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Jul 2015 16:59:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (mcp3021) Fix broken output scaling
Message-Id: <20150701165937.GB12711@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150629214453.GA30170@nick.stevens-ubuntu>
In-Reply-To: <20150629214453.GA30170@nick.stevens-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 01, 2015 at 03:39:34PM +0000, Stevens, Nick wrote:
> On Tue, Jun 30, 2015 at 08:11:14PM -0700, Guenter Roeck wrote:
> > Hi Nick,
> > 
> > On 06/29/2015 02:45 PM, Stevens, Nick wrote:
> > >The mcp3021 scaling code is dividing the VDD (full-scale) value in
> > >millivolts by the A2D resolution to obtain the scaling factor. When VDD
> > >is 3300mV (the standard value) and the resolution is 12-bit (4096
> > >divisions), the result is a scale factor of 3300/4096, which is always
> > >one.  Effectively, the raw A2D reading is always being returned because
> > >no scaling is applied.
> > >
> > >This patch fixes the issue while still using only integer math by
> > >converting VDD to microvolts before dividing by resolution, and then
> > >converting back to millivolts at return.
> > >
> > >Signed-off-by: Nick Stevens <Nick.Stevens@digi.com>
> > >---
> > >  drivers/hwmon/mcp3021.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
> > >index d219c06..c3bbba2 100644
> > >--- a/drivers/hwmon/mcp3021.c
> > >+++ b/drivers/hwmon/mcp3021.c
> > >@@ -87,10 +87,15 @@ static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
> > >  	if (val = 0)
> > >  		return 0;
> > >
> > >-	val = val * data->output_scale - data->output_scale / 2;
> > >+	/* Convert VDD setting to uV and divide by resolution to get uV/bit */
> > >+	u32 uv_per_bit = (data->vdd * 1000) / (
> > >+				(1 << data->output_res) * data->output_scale);
> > >
> > >-	return val * DIV_ROUND_CLOSEST(data->vdd,
> > >-			(1 << data->output_res) * data->output_scale);
> > >+	/* Scale raw reading by uV/bit */
> > >+	u32 uv_val = val * uv_per_bit;
> > >+
> > >+	/* Convert back from uV to mV */
> > >+	return (u16)DIV_ROUND_CLOSEST(uv_val, 1000);
> > 
> > How about simplifying this to
> > 	return DIV_ROUND_CLOSEST(val * data->vdd,
> > 			(1 << data->output_res) * data->output_scale);
> > instead ? Result is pretty much the same as far as I can see.
> 
> Beautiful - not sure why I didn't see this originally.
> 
> > You forgot to multiply uv_val with scale, which causes the results
> > for MCP3021 to be wrong by a factor of 4.
> 
> Oops, yes I did. Thanks for the catch.
> 
> What's extra interesting about this is that your simplification above is
> also missing the scale factor. When I wrote out the whole thing I got:
> 	return DIV_ROUND_CLOSEST(val * data->vdd,
> 			(1 << data->output_res) * data->output_scale) *
> 			data->output_scale;
> which simplifies to just:
> 	return DIV_ROUND_CLOSEST(val * data->vdd, 1 << data->output_res);
> 

I kept the scaling separate as in the original code.

My test code was actually

	val = val * scale /* - scale / 2 */;

	return DIV_ROUND_CLOSEST(val * VDD, (1 << res) * scale);

If we drop the '- scale / 2', this matches your expression,
and multiplying val with scale just to divide it by scale afterwards
becomes unnecessary.

Note that you don't need the typecast before DIV_ROUND_CLOSEST.

> To make sure that all options were covered, I put together a small
> userspace C program to compare the different algorithm variants (I'll
> put the source at the bottom of this email). These are the results:
> 
> Full scale @ VDD300mV
>             12 bit  10 bit
>   Original    4095    4090
>       Nick    3296     824
> Simplified    3299    3297
> 
> The "Original" result shows the erroneous original output for both 12
> and 10 bit, the "Nick" result shows that I missed the output_scale for
> 10-bit, and the "Simplfied" result shows the end result that doesn't
> need output_scale.
> 
Pretty much what I did as well ;-)

> I'll send a patch with the updated calculation and remove output_scale.
> 
> > I have no idea why
> > 	val = val * data->output_scale - data->output_scale / 2;
> > in the original code subtracts data->output_scale / 2; that seems wrong to me.
> > Any idea ?
> 
> The DIV_ROUND_CLOSEST macro includes a divide-by-2 component in the
> numerator, so maybe the original author was trying to cancel that out?
> It's the only thing I can think of. I've tested the new code with
> MCP3221 hardware, so I know that it works without the divide-by-2. I
> don't have a MCP3021 to test with, so I have to go on the datasheet for
> that one, but I don't see anything...
> 
Me not either.

If you drop the '- scale / 2', you can also drop the check if val = 0.

Can you send me the output of i2cdump for the chip ? I would like to add
it to my module tests.

Thanks,
Guenter

> > 
> > Thanks,
> > Guenter
> > 
> 
> Source code for algorithm comparison:
> 
> 
> #include <stdio.h>
> #include <stdint.h>
> 
> #define DIV_ROUND_CLOSEST(x, divisor)(			\
> {							\
> 	typeof(x) __x = x;				\
> 	typeof(divisor) __d = divisor;			\
> 	(((typeof(x))-1) > 0 ||				\
> 	 ((typeof(divisor))-1) > 0 || (__x) > 0) ?	\
> 		(((__x) + ((__d) / 2)) / (__d)) :	\
> 		(((__x) - ((__d) / 2)) / (__d));	\
> }							\
> )
> 
> uint16_t test_original(uint32_t vdd, uint16_t val, uint8_t output_res,
> 		       uint8_t output_scale)
> {
> 	val = val * output_scale - output_scale / 2;
> 	return val * DIV_ROUND_CLOSEST(vdd, (1 << output_res) * output_scale);
> }
> 
> uint16_t test_nick(uint32_t vdd, uint16_t val, uint8_t output_res,
> 		   uint8_t output_scale)
> {
> 	uint32_t uv_per_bit = (vdd * 1000) / (
> 				(1 << output_res) * output_scale);
> 	uint32_t uv_val = val * uv_per_bit;
> 	return (uint16_t)DIV_ROUND_CLOSEST(uv_val, 1000);
> }
> 
> uint16_t test_simplified(uint32_t vdd, uint16_t val, uint8_t output_res,
> 			 uint8_t output_scale)
> {
>     return DIV_ROUND_CLOSEST(val * vdd, 1 << output_res);
> }
> 
> int main(int argc, char *argv[])
> {
> 	char const *hdr = "%10s  %6s  %6s\n";
> 	char const *fmt = "%10s  %6d  %6d\n";
> 	puts("Full scale @ VDD300mV");
> 	printf(hdr, "", "12 bit", "10 bit");
> 	printf(fmt, "Original", test_original(3300, 0xFFF, 12, 1),
> 	       test_original(3300, 0x3FF, 10, 4));
> 	printf(fmt, "Nick", test_nick(3300, 0xFFF, 12, 1),
> 	       test_nick(3300, 0x3FF, 10, 4));
> 	printf(fmt, "Simplified", test_simplified(3300, 0xFFF, 12, 1),
> 	       test_simplified(3300, 0x3FF, 10, 4));
> 
> 	return 0;
> }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

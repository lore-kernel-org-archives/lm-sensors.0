From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 06 Nov 2011 16:01:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix documentation of
Message-Id: <20111106160122.GB25483@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111101111936.416dd882@endymion.delvare>
In-Reply-To: <20111101111936.416dd882@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 05, 2011 at 09:57:14AM -0400, Jean Delvare wrote:
> On Tue, 1 Nov 2011 06:57:36 -0700, Guenter Roeck wrote:
> > On Tue, Nov 01, 2011 at 06:19:36AM -0400, Jean Delvare wrote:
> > > The NCT6775F and NCT6776F have specific temperature sensor resolutions
> > > for sensors above 3.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > > Guenter, did I get it right?
> > > 
> > Did I add the 0.0 degrees note ? Brr.
> 
> I've done worse...
> 
> > Anyway, it is kind of correct. temp7 to temp9 resolution is 0.5 degrees C, but the code
> > only reads full degrees because it was too complicated to merge the lowest bit.
> 
> It is indeed different from the other values but I wouldn't call it
> terribly complicated. My only worry is related to the integrity of the
> reading, i.e. how can we guarantee that the MSB and the LSB belong to
> the same measurement. I would hope that the chip latches the LSB when
> the MSB is read, but I don't see any mention of this in the datasheet.
> The problem isn't limited to temp7 to temp9, BTW, other 9-bit
> temperature inputs are affected too.
> 
> Would the following (untested) be OK with you?
> 
> ---
>  drivers/hwmon/w83627ehf.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- linux-3.2-rc0.orig/drivers/hwmon/w83627ehf.c	2011-11-05 12:42:03.000000000 +0100
> +++ linux-3.2-rc0/drivers/hwmon/w83627ehf.c	2011-11-05 14:48:33.000000000 +0100
> @@ -260,6 +260,7 @@ static const u16 NCT6775_REG_TEMP_OVER[]
>  	= { 0x39, 0x155, 0x255, 0, 0, 0, 0x672, 0x677, 0x67C };
>  static const u16 NCT6775_REG_TEMP_SOURCE[]
>  	= { 0x621, 0x622, 0x623, 0x100, 0x200, 0x300, 0x624, 0x625, 0x626 };
> +#define NCT6775_REG_TEMP_LSB		0x62E
>  
>  static const char *const w83667hg_b_temp_label[] = {
>  	"SYSTIN",
> @@ -888,6 +889,17 @@ static struct w83627ehf_data *w83627ehf_
>  				  = w83627ehf_read_temp(data,
>  						data->reg_temp_hyst[i]);
>  		}
> +		/* LSB of temp7-9 are stored in the same register */
> +		if (data->have_temp & (0x7 << 6)) {
> +			u8 reg = w83627ehf_read_value(data,
> +						      NCT6775_REG_TEMP_LSB);
> +
> +			for (i = 0; i < 3; i++) {
> +				if (data->have_temp & (1 << (6 + i)))
> +					data->temp[6 + i]
> +					  |= (reg << (7 - i)) & 0x80;
> +			}
> +		}
>  
>  		data->alarms = w83627ehf_read_value(data,
>  					W83627EHF_REG_ALARM1) |
> 
Looks good to me. I'll test it on my system to be sure, and let you know.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

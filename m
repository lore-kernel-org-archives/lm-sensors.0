From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Jun 2010 07:33:42 +0000
Subject: Re: [lm-sensors] [PATCH] Add detection of SMSC EMC2103 to
Message-Id: <20100604093342.79e576c0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve,

On Sat, 22 May 2010 18:54:15 +0100, Steve Glendinning wrote:
> This patch allows the sensors-detect script to detect the SMSC
> EMC2103 family of temperature sensors and fan controllers.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
> ---
>  prog/detect/sensors-detect |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index 43b1095..7d59cee 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -1130,6 +1130,11 @@ use vars qw(@i2c_adapter_names);
>  		i2c_addrs => [0x2c..0x2e],
>  		i2c_detect => sub { dme1737_detect(@_, 2); },
>  	}, {
> +		name => "SMSC EMC2103",
> +		driver => "smscemc",

I don't much like this driver name. This driver won't support all the
SMSC EMC series, so it's confusing. If nothing else, the EMC1403,
EMC6D100, EMC6D101, EMC6D102 and EMC6D103 are already supported by two
other drivers (emc1403 and lm85). And there are many other SMSC EMC
chips, and I doubt they will all be compatible with the EMC2103, right?
So I would much prefer that you name your driver "emc2103".

> +		i2c_addrs => [0x2e],
> +		i2c_detect => sub { smsc_emc2103_detect(@_); },
> +	}, {
>  		name => "Fintek F75121R/F75122R/RG (VID+GPIO)",
>  		driver => "to-be-written",
>  		i2c_addrs => [0x4e], # 0x37 not probed
> @@ -5079,6 +5084,21 @@ sub smsc47m192_detect
>  	return ($addr = 0x2d ? 6 : 5);
>  }
>  
> +# Registers used:
> +#   0xFD: Product ID
> +#   0xFE: Manufacturer ID
> +#   0xFF: Revision

Your detection routine below doesn't actually use register 0xff. It
should if possible: this would make the detection more robust.

> +sub smsc_emc2103_detect
> +{
> +	my ($file, $addr) = @_;
> +	return unless i2c_smbus_read_byte_data($file, 0xFE) = 0x5D;
> +
> +	my $product = i2c_smbus_read_byte_data($file, 0xFD);
> +	return unless (($product = 0x24) || ($product = 0x26));
> +
> +	return 8;

You can't grant such a high confidence value after checking only 15
bits: it would rather be confidence 5 or 6. 

Also, the detection registers seem similar to the EMC1403's, so it
might make sense to reuse function emc1403_detect for the EMC2103,
instead of writing a new one.

> +}
> +
>  # Chip to detect: 1 = DME1737, 2 = SCH5027
>  # Registers used:
>  #   0x3E: Manufacturer ID


-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

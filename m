From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jun 2010 09:30:31 +0000
Subject: Re: [lm-sensors] [PATCH] Add detection of SMSC EMC2103 to
Message-Id: <20100607113031.74df4327@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100604093342.79e576c0@hyperion.delvare>
In-Reply-To: <20100604093342.79e576c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve,

On Sun,  6 Jun 2010 18:32:12 +0100, Steve Glendinning wrote:
> This patch allows the sensors-detect script to detect the SMSC
> EMC2103 family of temperature sensors and fan controllers.
> 
> Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
> ---
>  prog/detect/sensors-detect |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index e7f5ab2..9ffaf98 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -1130,6 +1130,11 @@ use vars qw(@i2c_adapter_names);
>  		i2c_addrs => [0x2c..0x2e],
>  		i2c_detect => sub { dme1737_detect(@_, 2); },
>  	}, {
> +		name => "SMSC EMC2103",
> +		driver => "emc2103",
> +		i2c_addrs => [0x2e],
> +		i2c_detect => sub { emc1403_detect(@_, 2); },
> +	}, {
>  		name => "Fintek F75121R/F75122R/RG (VID+GPIO)",
>  		driver => "to-be-written",
>  		i2c_addrs => [0x4e], # 0x37 not probed
> @@ -5143,7 +5148,7 @@ sub fintek_detect
>  	return 7;
>  }
>  
> -# Chip to detect: 0 = EMC1403, 1 = EMC1404
> +# Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103
>  # Registers used:
>  #   0xfd: Device ID register
>  #   0xfe: Vendor ID register
> @@ -5163,6 +5168,9 @@ sub emc1403_detect
>  	} elsif ($chip = 1) {
>  		return unless $dev_id = 0x25;
>  		return unless $rev = 0x01;
> +	} elsif ($chip = 2) {
> +		return unless ($dev_id = 0x24) || ($dev_id = 0x26);
> +		return unless $rev = 0x01;
>  	}
>  
>  	return 6;

Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

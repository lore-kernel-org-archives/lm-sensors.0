From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 20 Nov 2014 09:09:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] sensors-detect: Nuvoton chip updates
Message-Id: <20141120100914.4b9b619a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416333599-12717-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1416333599-12717-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 18 Nov 2014 09:59:58 -0800, Guenter Roeck wrote:
> Add reference to nct6883 driver.

I think you mean 6683? The same typo exists in the patch below and also
on wiki/Devices.

> Show that nct6775 driver supports NCT6792D.
> Show that NCT6102D/6104D/6106D are supported by nct6775 driver
> NCT5573D is compatible to NCT6776F and has the same chip ID.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    | 4 ++++
>  prog/detect/sensors-detect | 6 +++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/CHANGES b/CHANGES
> index 27cfa4d..62cfd24 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -17,6 +17,10 @@ SVN HEAD
>                    Add detection of NCT7802Y
>                    Print kernel version and processor information
>                    Add detection of NCT6792D 
> +                  Add reference to nct6883 driver
> +                  Show that NCT6102D/6104D/6106D are supported by nct6775 driver
> +                  Show that NCT5573D is compatible to NCT6776F and has the same
> +                  chip ID.

No tailing dot please, and as much as possible please try to make
descriptions fit on a single line.

>  
>  3.3.5 "Happy Birthday Beddy" (2014-01-22)
>    libsensors: Improve documentation of two functions
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index bb233e2..610338b 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -2096,7 +2096,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
>  		driver => "not-a-sensor",
>  		devid => 0x61,
>  	}, {
> -		name => "Nuvoton NCT5577D/NCT6776F Super IO Sensors",
> +		name => "Nuvoton NCT5573D/NCT5577D/NCT6776F Super IO Sensors",
>  		driver => "nct6775",
>  		devid => 0xC330,
>  		devid_mask => 0xFFF0,
> @@ -2111,7 +2111,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
>  		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
>  	}, {
>  		name => "Nuvoton NCT6683D eSIO",
> -		driver => "to-be-written",
> +		driver => "nct6883",
>  		devid => 0xC730,
>  		devid_mask => 0xFFF0,
>  		logdev => 0x0b,
> @@ -2132,7 +2132,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
>  		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
>  	}, {
>  		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",

The NCT6104D is not mentioned on wiki/Devices, please add it.

> -		driver => "to-be-written",	# nct6775
> +		driver => "nct6775",
>  		devid => 0xC450,
>  		devid_mask => 0xFFF0,
>  		logdev => 0x0b,

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

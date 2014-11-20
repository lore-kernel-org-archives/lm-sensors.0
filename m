From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 20 Nov 2014 18:54:20 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] sensors-detect: Nuvoton chip updates
Message-Id: <20141120195420.5a20c5a5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416501593-9141-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1416501593-9141-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 20 Nov 2014 08:39:52 -0800, Guenter Roeck wrote:
> Add reference to nct6683 driver.
> Show that nct6775 driver supports NCT6792D.
> Show that NCT6102D/6104D/6106D are supported by nct6775 driver.
> NCT5573D is compatible to NCT6776F and has the same chip ID.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Dropped '.' from CHANGES and shortened description of changes
>     nct6883 --> nct6683
> 
>  CHANGES                    | 3 +++
>  prog/detect/sensors-detect | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/CHANGES b/CHANGES
> index 27cfa4d..3be3da9 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -17,6 +17,9 @@ SVN HEAD
>                    Add detection of NCT7802Y
>                    Print kernel version and processor information
>                    Add detection of NCT6792D 
> +                  Add reference to nct6683 driver
> +                  Show that NCT6102D/6104D/6106D are supported by nct6775 driver
> +                  Show NCT5573D as compatible to NCT6776F with same chip ID
>  
>  3.3.5 "Happy Birthday Beddy" (2014-01-22)
>    libsensors: Improve documentation of two functions
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index bb233e2..2d9cc04 100755
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
> +		driver => "nct6683",
>  		devid => 0xC730,
>  		devid_mask => 0xFFF0,
>  		logdev => 0x0b,
> @@ -2132,7 +2132,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
>  		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
>  	}, {
>  		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
> -		driver => "to-be-written",	# nct6775
> +		driver => "nct6775",
>  		devid => 0xC450,
>  		devid_mask => 0xFFF0,
>  		logdev => 0x0b,

Looks good, please commit.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

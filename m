From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 23 Jan 2015 06:58:08 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of IT8786E
Message-Id: <20150123075808.640c2492@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 16 Jan 2015 13:45:55 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    | 1 +
>  prog/detect/sensors-detect | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/CHANGES b/CHANGES
> index e462aea..03eb7fb 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -26,6 +26,7 @@ SVN HEAD
>                    Add detection of EMC1422
>                    Document driver support for TMP431 and TMP432
>                    Add detection of TMP400 and TMP435
> +                  Add detection of IT8786E
>  
>  3.3.5 "Happy Birthday Beddy" (2014-01-22)
>    libsensors: Improve documentation of two functions
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index ebdc439..9b7ba8f 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -2388,6 +2388,12 @@ use constant FEAT_SMBUS	=> (1 << 7);
>  		devid => 0x8783,
>  		logdev => 0x04,
>  		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
> +	}, {
> +		name => "ITE IT8786E Super IO Sensors",
> +		driver => "to-be-written",	# it87
> +		devid => 0x8786,
> +		logdev => 0x04,
> +		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
>  	}
>  );
>  

Looks good, please commit.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

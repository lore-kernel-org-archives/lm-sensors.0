From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 25 Jan 2014 22:05:19 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of TI ADC128D818
Message-Id: <20140125230519.45f4e6e0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 25 Jan 2014 09:54:51 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |    3 +++
>  prog/detect/sensors-detect |   26 +++++++++++++++++++++-----
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/CHANGES b/CHANGES
> index e1347a6..970dd67 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -1,6 +1,9 @@
>  lm-sensors CHANGES file
>  -----------------------
>  
> +SVN HEAD
> +  sensors-detect: Add detection of ADC128D818
> +
>  3.3.5 "Happy Birthday Beddy" (2014-01-22)
>    libsensors: Improve documentation of two functions
>                Increase MAX_SENSORS_PER_TYPE to 33
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index a2093f3..2136b76 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -547,6 +547,11 @@ use vars qw(@i2c_adapter_names);
>  		i2c_addrs => [0x28..0x2f],
>  		i2c_detect => sub { lm80_detect(@_, 1); },
>  	}, {
> +		name => "TI / National Semiconductor ADC128D818",
> +		driver => "adc128d818",
> +		i2c_addrs => [0x1d, 0x1e, 0x1f, 0x2d, 0x2e, 0x2f, 0x35, 0x36, 0x37],
> +		i2c_detect => sub { lm80_detect(@_, 2); },

How does this relate to the LM80?

Is this chip really something people will need sensors-detect for (i.e.
it is found in PC-like computers) or something which will be always
declared in DT-like declarations anyway?

I'm asking because I am worried about the address list. I'm fine with
0x1d..0x1f and 0x2d..0x2f (you can declare them that way in perl BTW,
it's more compact) but addresses 0x35..0x37 we don't currently scan.
Adding a new address to the scan list is always a risk, as you may start
probing a whole new class of devices and the effects can be very bad.

Actually we used to scan address 0x37 until r3233 / 2006-01-16. Commit
message was:

"Lower the confidence of ITE overclocking chips. Do not scan
address 0x37 for these chips, as it may cause problem with some
eeproms."

Addresses 0x35 and 0x36 I don't think we ever scanned, but EEPROMs can
reply to these as well so I'd rather not add them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

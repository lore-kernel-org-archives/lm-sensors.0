From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 Jun 2013 18:39:19 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Drop outdated comment about MAX1617 and LM84 detection
Message-Id: <20130607203919.4a4d1a5a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370627255-7438-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370627255-7438-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri,  7 Jun 2013 10:47:35 -0700, Guenter Roeck wrote:
> Drop comment that additional checks for MAX1617 and LM84 are not
> done in adm1021 driver, as this is no longer correct.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  prog/detect/sensors-detect |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index 19bfe1a..518e5d8 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -5534,8 +5534,7 @@ sub adm1021_detect
>  
>  	# Extra checks for MAX1617 and LM84, since those are often misdetected.
>  	# We verify several assertions (6 for the MAX1617, 4 for the LM84) and
> -	# discard the chip if any fail. Note that these checks are not done
> -	# by the adm1021 driver.
> +	# discard the chip if any fail.
>  	if ($chip = 2 || $chip = 5) {
>  		my $lte = i2c_smbus_read_byte_data($file, 0x00);
>  		my $rte = i2c_smbus_read_byte_data($file, 0x01);

Yep, please just commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

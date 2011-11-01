From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 01 Nov 2011 13:57:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix documentation of
Message-Id: <20111101135736.GA6669@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111101111936.416dd882@endymion.delvare>
In-Reply-To: <20111101111936.416dd882@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 01, 2011 at 06:19:36AM -0400, Jean Delvare wrote:
> The NCT6775F and NCT6776F have specific temperature sensor resolutions
> for sensors above 3.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Guenter, did I get it right?
> 
Did I add the 0.0 degrees note ? Brr.

Anyway, it is kind of correct. temp7 to temp9 resolution is 0.5 degrees C, but the code
only reads full degrees because it was too complicated to merge the lowest bit.

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks,
Guenter

>  Documentation/hwmon/w83627ehf |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- linux-3.2-rc0.orig/Documentation/hwmon/w83627ehf	2011-10-31 17:00:50.000000000 +0100
> +++ linux-3.2-rc0/Documentation/hwmon/w83627ehf	2011-11-01 10:55:03.000000000 +0100
> @@ -62,8 +62,9 @@ sensors. The configured source for each
>  in tempX_label.
>  
>  Temperatures are measured in degrees Celsius and measurement resolution is 1
> -degC for temp1 and and 0.5 degC for temp2 and temp3. For temp4 and higher,
> -resolution is 1 degC for W83667HG-B and 0.0 degC for NCT6775F and NCT6776F.
> +degC for temp1 and and 0.5 degC for temp2 and temp3. For W83667HG-B, temp4
> +has resolution 1 degC. For NCT6775F and NCT6776F, temp4 to temp6 have
> +resolution 0.5 degC, while temp7 to temp9 have resolution 1 degC.
>  An alarm is triggered when the temperature gets higher than high limit;
>  it stays on until the temperature falls below the hysteresis value.
>  Alarms are only supported for temp1, temp2, and temp3.
> 
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

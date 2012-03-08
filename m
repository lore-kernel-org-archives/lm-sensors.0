From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Mar 2012 17:15:08 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (jc42) Remove unnecessary device IDs
Message-Id: <20120308181508.4c83d0e2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331226547-21954-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331226547-21954-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu,  8 Mar 2012 09:09:07 -0800, Guenter Roeck wrote:
> We don't really use or need separate device IDs for the various JC42.4 compliant
> chips, so remove them and just stick with jc42.
> 
> Also update a datasheet references for SE98A, STTS424, and STTS424E02.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Merged Prefix/Addresses scanned information
> 
>  Documentation/hwmon/jc42 |   39 +++++++++------------------------------
>  drivers/hwmon/jc42.c     |   18 ------------------
>  2 files changed, 9 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
> index 52729a7..66ecb9f 100644
> --- a/Documentation/hwmon/jc42
> +++ b/Documentation/hwmon/jc42
> @@ -3,71 +3,50 @@ Kernel driver jc42
>  
>  Supported chips:
>    * Analog Devices ADT7408
> -    Prefix: 'adt7408'
> -    Addresses scanned: I2C 0x18 - 0x1f
>      Datasheets:
>  	http://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
>    * Atmel AT30TS00
> -    Prefix: 'at30ts00'
> -    Addresses scanned: I2C 0x18 - 0x1f
>      Datasheets:
>  	http://www.atmel.com/Images/doc8585.pdf
> (...)

OK.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

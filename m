From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Sep 2012 08:57:39 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (Documentation) Update feature-removal-schedule.txt
Message-Id: <20120905105739.5046c47d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346810610-26352-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1346810610-26352-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  4 Sep 2012 19:03:30 -0700, Guenter Roeck wrote:
> Legacy sysfs attributes for chassis intrusion detection have been removed.
> Update feature-removal-schedule.txt to reflect it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/feature-removal-schedule.txt |   10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index afaff31..51c7b52 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -389,16 +389,6 @@ Who:	Wey-Yi Guy <wey-yi.w.guy@intel.com>
>  
>  ----------------------------
>  
> -What:	Legacy, non-standard chassis intrusion detection interface.
> -When:	June 2011
> -Why:	The adm9240, w83792d and w83793 hardware monitoring drivers have
> -	legacy interfaces for chassis intrusion detection. A standard
> -	interface has been added to each driver, so the legacy interface
> -	can be removed.
> -Who:	Jean Delvare <khali@linux-fr.org>
> -
> -----------------------------
> -
>  What:	i2c_driver.attach_adapter
>  	i2c_driver.detach_adapter
>  When:	September 2011

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

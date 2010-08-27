From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Aug 2010 11:58:20 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add tempX_emergency attribute to
Message-Id: <20100827135820.5a093229@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282900309-17074-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1282900309-17074-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, "Ira W. Snyder" <iws@ovro.caltech.edu>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-doc@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, 27 Aug 2010 02:11:49 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> v2: Re-phrased attribute description
> 
>  Documentation/hwmon/sysfs-interface |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index ff45d1f..101300b 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -310,6 +310,13 @@ temp[1-*]_crit_hyst
>  		from the critical value.
>  		RW
>  
> +temp[1-*]_emergency
> +		Temperature emergency max value, for chips supporting more than
> +		two upper temperature limits. Must be equal or greater than
> +		corresponding temp_crit values.
> +		Unit: millidegree Celsius
> +		RW
> +
>  temp[1-*]_lcrit	Temperature critical min value, typically lower than
>  		corresponding temp_min values.
>  		Unit: millidegree Celsius

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

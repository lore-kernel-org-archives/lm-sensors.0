From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Jan 2012 17:12:17 +0000
Subject: Re: [lm-sensors] [PATCH] applesmc: Silence uninitialized warnings
Message-Id: <1327597937.2649.216.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327576121-2073-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1327576121-2073-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2012-01-26 at 06:08 -0500, Henrik Rydberg wrote:
> Some error paths do not set a result, leading to the (false)
> assumption that the value may be used uninitialized. Set results for
> those paths as well.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hwmon/applesmc.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index b989553..11f79bb 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -344,8 +344,10 @@ static int applesmc_get_lower_bound(unsigned int *lo, const char *key)
>  	while (begin != end) {
>  		int middle = begin + (end - begin) / 2;
>  		entry = applesmc_get_entry_by_index(middle);
> -		if (IS_ERR(entry))
> +		if (IS_ERR(entry)) {
> +			*lo = 0;
>  			return PTR_ERR(entry);
> +		}
>  		if (strcmp(entry->key, key) < 0)
>  			begin = middle + 1;
>  		else
> @@ -364,8 +366,10 @@ static int applesmc_get_upper_bound(unsigned int *hi, const char *key)
>  	while (begin != end) {
>  		int middle = begin + (end - begin) / 2;
>  		entry = applesmc_get_entry_by_index(middle);
> -		if (IS_ERR(entry))
> +		if (IS_ERR(entry)) {
> +			*hi = smcreg.key_count;
>  			return PTR_ERR(entry);
> +		}
>  		if (strcmp(key, entry->key) < 0)
>  			end = middle;
>  		else

That was an annoying warning .. I checked the code several times by now
to make sure it is not real. Good idea to fix it.

Applied to -next for now. Linus did not (yet) accept my last set of
patches, so I am not sure if it was too much cleanup for a release
candidate.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

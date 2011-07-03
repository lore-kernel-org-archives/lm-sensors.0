From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jul 2011 11:14:28 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (pmbus) Auto-detect temp2 and
Message-Id: <20110703131428.038774d4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309454993-8641-5-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309454993-8641-5-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 30 Jun 2011 10:29:53 -0700, Guenter Roeck wrote:
> Additional temperature attribute support is easy to detect, so do it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/pmbus.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
> index b0ea00b..931d940 100644
> --- a/drivers/hwmon/pmbus.c
> +++ b/drivers/hwmon/pmbus.c
> @@ -65,6 +65,10 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
>  					      PMBUS_STATUS_TEMPERATURE))
>  			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
>  	}
> +	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_2))
> +		info->func[0] |= PMBUS_HAVE_TEMP2;
> +	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
> +		info->func[0] |= PMBUS_HAVE_TEMP3;

Looks good, but is it not possible for a device to have temp2 (or
temp3) but not temp1? If it is, then the test for
PMBUS_STATUS_TEMPERATURE should be moved after the test for
PMBUS_READ_TEMPERATURE_3, and should depend on any of PMBUS_HAVE_TEMP*
being set. If it is not possible, then the code is fine as it is and:

Acked-by: Jean Delvare <khali@linux-fr.org>

>  
>  	/* Sensors detected on all pages */
>  	for (page = 0; page < info->pages; page++) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

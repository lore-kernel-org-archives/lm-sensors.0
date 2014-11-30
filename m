From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 30 Nov 2014 20:01:21 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/5] hwmon: ina2xx: make shunt resistance configurable at run-time
Message-Id: <547B7791.8030108@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417082350-23470-1-git-send-email-bgolaszewski@baylibre.com> <1417082350-23470-3-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417082350-23470-3-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <jdelvare@suse.de>

On 11/27/2014 01:59 AM, Bartosz Golaszewski wrote:
> The shunt resistance can only be set via platform_data or device tree. This
> isn't suitable for devices in which the shunt resistance can change/isn't
> known at boot-time.
>
> Add a sysfs attribute that allows to read and set the shunt resistance.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/hwmon/ina2xx.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index 0a6b60f..341da67 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -51,6 +51,8 @@
>   #define INA226_ALERT_LIMIT		0x07
>   #define INA226_DIE_ID			0xFF
>
> +/* shunt resistor sysfs attribute index */
> +#define INA2XX_RSHUNT			0x8
>
After reading the datasheet again ... those defines were meant
to reflect registers, not to create 'dummy' index values for software.
Please rearrange your code to not require such constructs; it is just
confusing for others (including me).

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Wed, 17 Jun 2009 21:58:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) DMI probing for AB9,
Message-Id: <200906172258.57072.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Argh.. git send-email messed me around and I accidentally sent out a test 
copy. Adding the list to CC..

On Wednesday 17 June 2009 22:55:16 Alistair John Strachan wrote:
> Switch the AB9, AB9 QuadQT and IX38 QuadGT over from port
> probing to the preferred DMI probe method.
>
> Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
> Tested-by: dan <dan@deeog.com>
> Tested-by: Nygel Lyndley <nygel.lyndley@gmail.com>
> Tested-by: Dmitriy Fedchenko <dmitriy-fedc@yandex.ru>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/abituguru3.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> index ad2b343..7d3f15d 100644
> --- a/drivers/hwmon/abituguru3.c
> +++ b/drivers/hwmon/abituguru3.c
> @@ -357,7 +357,7 @@ static const struct abituguru3_motherboard_info
> abituguru3_motherboards[] = { { "AUX5 Fan",		39, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
> -	{ 0x0014, NULL /* Abit AB9 Pro, need DMI string */, {
> +	{ 0x0014, "AB9", /* + AB9 Pro */ {
>  		{ "CPU Core",		 0, 0, 10, 1, 0 },
>  		{ "DDR",		 1, 0, 10, 1, 0 },
>  		{ "DDR VTT",		 2, 0, 10, 1, 0 },
> @@ -455,7 +455,7 @@ static const struct abituguru3_motherboard_info
> abituguru3_motherboards[] = { { "AUX3 FAN",		37, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
> -	{ 0x0018, NULL /* Unknown, need DMI string */, {
> +	{ 0x0018, "AB9 QuadGT", {
>  		{ "CPU Core",		 0, 0, 10, 1, 0 },
>  		{ "DDR2",		 1, 0, 20, 1, 0 },
>  		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
> @@ -564,7 +564,7 @@ static const struct abituguru3_motherboard_info
> abituguru3_motherboards[] = { { "AUX3 Fan",		36, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
> -	{ 0x001C, NULL /* Unknown, need DMI string */, {
> +	{ 0x001C, "IX38 QuadGT", {
>  		{ "CPU Core",		 0, 0, 10, 1, 0 },
>  		{ "DDR2",		 1, 0, 20, 1, 0 },
>  		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

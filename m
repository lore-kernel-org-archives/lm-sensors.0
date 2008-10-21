From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 17:19:49 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (abituguru3) match partial DMI
Message-Id: <48FE0F35.2040904@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1224608373-27352-4-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1224608373-27352-4-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Alistair John Strachan wrote:
> Abit DMI product name strings are composed of the product branding
> and the north/south bridge chipset names, respectively.
> 
> Unfortunately, these components are inconsistently separated by a
> variable number of spaces. On some boards, there is no space, and on
> others, there are many spaces.
> 
> Since we don't care about matching bridge chipset names, update the
> DMI probe routine to only match the first N characters of the DMI
> product name, and update the motherboard table to include only the
> product branding.
> 
> This change preemptively works around potential variances in the DMI
> product string between different BIOS revisions for the same board.
> 
> Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
> Tested-by: Justin Piszcz <jpiszcz@lucidpixels.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jean Delvare <khali@linux-fr.org>

Looks good,

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/hwmon/abituguru3.c |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> index ff6aad8..59b3d02 100644
> --- a/drivers/hwmon/abituguru3.c
> +++ b/drivers/hwmon/abituguru3.c
> @@ -279,7 +279,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
>  		{ "OTES1 Fan",		36, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
> -	{ 0x0011, "AT8 32X(ATI RD580-ULI M1575)", {
> +	{ 0x0011, "AT8 32X", {
>  		{ "CPU Core",		 0, 0, 10, 1, 0 },
>  		{ "DDR",		 1, 0, 20, 1, 0 },
>  		{ "DDR VTT",		 2, 0, 10, 1, 0 },
> @@ -402,7 +402,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
>  		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
> -	{ 0x0016, "AW9D-MAX       (Intel i975-ICH7)", {
> +	{ 0x0016, "AW9D-MAX", {
>  		{ "CPU Core",		 0, 0, 10, 1, 0 },
>  		{ "DDR2",		 1, 0, 20, 1, 0 },
>  		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
> @@ -509,7 +509,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
>  		{ "AUX3 FAN",		36, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
> -	{ 0x001A, "IP35 Pro(Intel P35-ICH9R)", {
> +	{ 0x001A, "IP35 Pro", {
>  		{ "CPU Core",		 0, 0, 10, 1, 0 },
>  		{ "DDR2",		 1, 0, 20, 1, 0 },
>  		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
> @@ -1139,7 +1139,17 @@ static int __init abituguru3_dmi_detect(void)
>  
>  	for (i = 0; abituguru3_motherboards[i].id; i++) {
>  		const char *dmi_name = abituguru3_motherboards[i].dmi_name;
> -		if (dmi_name && !strcmp(dmi_name, board_name))
> +
> +		/*
> +		 * Some of the vendor DMI strings are formatted inconsistently
> +		 * e.g. "Board Name(Chipset)" vs "Board Name      (Chipset)"
> +		 *
> +		 * Work around this ambiguity by only matching partial DMI
> +		 * board name strings, in an effort to avoid potential
> +		 * variances between vendor BIOS revisions.
> +		 */
> +		if (dmi_name &&
> +		    !strncmp(dmi_name, board_name, strlen(dmi_name)))
>  			break;
>  	}
>  

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

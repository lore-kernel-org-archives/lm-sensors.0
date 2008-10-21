From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 21 Oct 2008 17:19:05 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (abituguru3) enable DMI probing
Message-Id: <48FE0F09.6080803@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1224608373-27352-3-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1224608373-27352-3-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Alistair John Strachan wrote:
> Switch the AW9D-MAX over from port probing to the preferred DMI
> probe method.
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
>  drivers/hwmon/abituguru3.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> index d9e7a49..ff6aad8 100644
> --- a/drivers/hwmon/abituguru3.c
> +++ b/drivers/hwmon/abituguru3.c
> @@ -402,7 +402,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
>  		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
>  		{ NULL, 0, 0, 0, 0, 0 } }
>  	},
> -	{ 0x0016, NULL /* AW9D-MAX, need DMI string */, {
> +	{ 0x0016, "AW9D-MAX       (Intel i975-ICH7)", {
>  		{ "CPU Core",		 0, 0, 10, 1, 0 },
>  		{ "DDR2",		 1, 0, 20, 1, 0 },
>  		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

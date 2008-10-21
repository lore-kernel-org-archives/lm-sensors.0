From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Oct 2008 19:53:00 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (abituguru3) match partial DMI
Message-Id: <20081021215300.612c4909@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1224608373-27352-4-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1224608373-27352-4-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alistair, Hans,

On Tue, 21 Oct 2008 17:59:33 +0100, Alistair John Strachan wrote:
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

I know that I'm the one who suggested this change, but... Are there no
known Abit boards those name is another board's name with an added
suffix? Looking at this list for example:
http://www.abit.com.tw/page/en/motherboard/motherboard_type.php?fMTYPE=Socket+AM2
I see "AN52V", "AN52 V2.0", "AN52" and "AN52S". An entry "AN52" in the
abituguru3_motherboards table would match all 4 boards. And there are
other examples such as "AW9D" and "AW9D-MAX" (which is even more
relevant as the latter is in the abituguru3_motherboards table already.)

So I don't think that the implementation above is safe, unless the
entries in abituguru3_dmi_detect are sorted specifically to make the
short string comparison always correct. But that's easy to screw this
up later.

An alternative would be to make a slightly more customized comparison
function: instead of passing strlen(dmi_name) as the length parameter
of strncmp(), you would compute the length by looking for the last
non-space character before the opening parenthesis in board_name. This
would require some more code, but would be more robust. Whether it's
worth it, I'll leave up to you: either do that or leave the code as it
is now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

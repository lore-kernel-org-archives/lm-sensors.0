From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 15 Jan 2009 14:59:09 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (abituguru3) match partial DMI
Message-Id: <20090115155909.3037fe4c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1231865798-12187-2-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1231865798-12187-2-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Jan 2009 16:56:37 +0000, Alistair John Strachan wrote:
> The switch-over to using DMI board strings to identify abituguru3 compatible
> mainboards works most of the time, but sometimes the vendor has substantially
> modified the board string between BIOS revisions.
> 
> We have found that the vendor chipset identification string (provided in
> brackets) changes frequently and is of no use to us. The rest of the board
> string sometimes changes in subtle ways, e.g. whitespace or variations in
> capitalization.
> 
> The new comparison code checks only a part of the supplied DMI board string,
> trimming the bracketed content, whitespace, and ignoring case as necessary.
> 
> This fixes a bug where an IP35 Pro running an early BIOS would not be
> detected without the force=1 module parameter, and also speculatively
> fixes other similiar issues.
> 
> Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
> Reported-by: Nick Pasich <NewsLetters@nickandbarb.net>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/abituguru3.c |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> index 70bb854..16d3142 100644
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
> @@ -1128,6 +1128,7 @@ static int __init abituguru3_dmi_detect(void)
>  {
>  	const char *board_vendor, *board_name;
>  	int i, err = (force) ? 1 : -ENODEV;
> +	size_t sublen;
>  
>  	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
>  	if (!board_vendor || strcmp(board_vendor, "http://www.abit.com.tw/"))
> @@ -1137,9 +1138,20 @@ static int __init abituguru3_dmi_detect(void)
>  	if (!board_name)
>  		return err;
>  
> +	/* At the moment, we don't care about the part of the vendor
> +	 * DMI string contained in brackets. Truncate the string at
> +	 * the first occurence of a bracket. Trim any trailing space
> +	 * from the substring.
> +	 */
> +	sublen = strcspn(board_name, "(");
> +	while (sublen > 0 && board_name[sublen - 1] = ' ')
> +		sublen--;
> +
>  	for (i = 0; abituguru3_motherboards[i].id; i++) {
>  		const char *dmi_name = abituguru3_motherboards[i].dmi_name;
> -		if (dmi_name && !strcmp(dmi_name, board_name))
> +		if (!dmi_name || strlen(dmi_name) != sublen)
> +			continue;
> +		if (!strncasecmp(board_name, dmi_name, sublen))
>  			break;
>  	}
>  

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 06 Sep 2009 07:23:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) Support multiple DMI
Message-Id: <4AA36388.2090708@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 09/05/2009 07:13 PM, Alistair John Strachan wrote:
> Most known Abit motherboards have unique uguru chip IDs. However,
> some "refresh" boards keep the same chip ID but have a different
> DMI string. As our DMI board string matching is (necessarily)
> strict, some boards were failing DMI detection, and as the old
> probe method was also failing, the driver would not load.
>
> The only known boards affected by this problem are the IP35 Pro XE
> (vs IP35 Pro) and the AB9 Pro (vs AB9). Is it not sufficient to
> relax the match criteria, as some boards (e.g. the AB9 Quad GT)
> have different uguru chip IDs.
>
> This patch replaces the dmi_name string with a NULL terminated
> array of strings to be matched per uguru chip ID. It has been
> compile and runtime tested (thanks Rune).
>
> References: https://bugs.launchpad.net/bugs/298798
>
> Signed-off-by: Alistair John Strachan<alistair@devzero.co.uk>
> Tested-by: Rune Svendsen<runesvend@gmail.com>
> Cc: Rune Svendsen<runesvend@gmail.com>
> Cc: Hans de Goede<hdegoede@redhat.com>
> Cc: lm-sensors@lm-sensors.org
>
> ---
>   drivers/hwmon/abituguru3.c |   63 +++++++++++++++++++++++--------------------
>   1 files changed, 34 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
> index 7d3f15d..5203ec2 100644
> --- a/drivers/hwmon/abituguru3.c
> +++ b/drivers/hwmon/abituguru3.c

<snip>

> @@ -947,7 +951,7 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
>   		"ID: %04X\n", (unsigned int)id);
>
>   #ifdef CONFIG_DMI
> -	if (!abituguru3_motherboards[i].dmi_name) {
> +	if (!*abituguru3_motherboards[i].dmi_name) {
>   		printk(KERN_WARNING ABIT_UGURU3_NAME ": this motherboard was "
>   			"not detected using DMI. Please send the output of "
>   			"\"dmidecode\" to the abituguru3 maintainer "

I would prefer to see you write this as:
+	if (!abituguru3_motherboards[i].dmi_name[0]) {

This is better readable IMHO (I always dislike people using the singleton *
operator when they want to get the first member of an array. The singleton
* operator is for getting the content of a pointer).

Note this is in no way a blocker for this patch, just my preference.

> @@ -1131,6 +1135,7 @@ static int __init abituguru3_dmi_detect(void)
>   {
>   	const char *board_vendor, *board_name;
>   	int i, err = (force) ? 1 : -ENODEV;
> +	const char *const *dmi_name;
>   	size_t sublen;
>
>   	board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
> @@ -1151,17 +1156,17 @@ static int __init abituguru3_dmi_detect(void)
>   		sublen--;
>
>   	for (i = 0; abituguru3_motherboards[i].id; i++) {
> -		const char *dmi_name = abituguru3_motherboards[i].dmi_name;
> -		if (!dmi_name || strlen(dmi_name) != sublen)
> -			continue;
> -		if (!strncasecmp(board_name, dmi_name, sublen))
> -			break;
> +		dmi_name = abituguru3_motherboards[i].dmi_name;
> +		for ( ; *dmi_name; dmi_name++) {
> +			if (strlen(*dmi_name) != sublen)
> +				continue;
> +			if (!strncasecmp(board_name, *dmi_name, sublen))
> +				return 0;
> +		}
>   	}
>
> -	if (!abituguru3_motherboards[i].id)
> -		return 1;
> -
> -	return 0;
> +	/* No match found */
> +	return 1;
>   }
>
>   #else /* !CONFIG_DMI */

Other then that the patch looks good to me.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

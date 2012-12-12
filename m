From: "Gabriel L. Somlo" <somlo@cmu.edu>
Date: Wed, 12 Dec 2012 23:01:28 +0000
Subject: Re: [lm-sensors] [PATCH v2] applesmc: add sysfs file to report OSK
Message-Id: <20121212230128.GE16373@lobsang.ini.cmu.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121210195414.GA642@polaris.bitmath.org>
 <20121210222313.GF2097@hedwig.ini.cmu.edu>
In-Reply-To: <20121210222313.GF2097@hedwig.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Guenter Roeck <groeck-dsl@sbcglobal.net>, khali@linux-fr.org, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, agraf@suse.de, rene@exactcode.com

Henrik, I agree with you that it's silly to poke the hardware for a
string we KNOW will NEVER change :)

That being said, I too would love to live in a world where technical
common sense prevailed over bullshit lawyerly tactics, "corporate
strategies", and the ensuing FUD.

The way things stand today, in order to boot Mac OS X on QEMU/KVM/Linux
(running on Mac hardware of course, in compliance with Apple's license)
requires the end user supplying the OSK on the QEMU command line via the
-osk="..." argument.

I would like to make it easy for people who run Linux natively on Apple
hardware (of which I am one) to run OS X from QEMU "out of the box".

I could try to hardcode the OSK inside QEMU, or I could try to include
it as a default config file entry, but I'm quite certain the QEMU project
would be uncomfortable "distributing" a string on which Apple claims
copyright. Even if that happened, distros might then balk at shipping
QEMU as part of their package repositories, for the exact same reason.

Currently, we're all beating around the bush about the OSK, with vague
hints and hoops to jump through for end users to acquire the OSK and
pass it to QEMU on the command line. This process will have the
unfortunate side effect of filtering out "normal" users :(

The only viable (from a legal CYA standpoint) thing I can think of is
to make it easy to acquire the OSK automatically, on demand, directly
from the hardware. Right now, the logical place for that is applesmc.ko.
It already controls access to the SMC, and already reports values for
various keys.

Yes it may feel silly to "go through the motions" when you KNOW it's
always going to be the same value that gets returned. But this patch
is mostly about reassuring people that lawyers will continue not to
have a reason to get involved...

Thanks for reading, and hope I'm being sufficiently persuasive :)
--Gabriel

>  drivers/hwmon/applesmc.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index b41baff..b37b271 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -1013,6 +1013,24 @@ static ssize_t applesmc_key_at_index_store(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t applesmc_osk_show(struct device *dev,
> +				struct device_attribute *attr, char *sysfsbuf)
> +{
> +	int ret;
> +	char buf[65];
> +
> +	mutex_lock(&smcreg.mutex);
> +	ret = read_smc(APPLESMC_READ_CMD, "OSK0", buf, 32);
> +	if (!ret)
> +		ret = read_smc(APPLESMC_READ_CMD, "OSK1", buf + 32, 32);
> +	mutex_unlock(&smcreg.mutex);
> +	if (ret)
> +		return ret;
> +
> +	buf[64] = '\0';
> +	return snprintf(sysfsbuf, PAGE_SIZE, "%s\n", buf);
> +}
> +
>  static struct led_classdev applesmc_backlight = {
>  	.name			= "smc::kbd_backlight",
>  	.default_trigger	= "nand-disk",
> @@ -1027,6 +1045,7 @@ static struct applesmc_node_group info_group[] = {
>  	{ "key_at_index_type", applesmc_key_at_index_type_show },
>  	{ "key_at_index_data_length", applesmc_key_at_index_data_length_show },
>  	{ "key_at_index_data", applesmc_key_at_index_read_show },
> +	{ "osk", applesmc_osk_show },
>  	{ }
>  };
>  
> -- 
> 1.7.7.6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

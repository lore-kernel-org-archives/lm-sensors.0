From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 May 2006 21:19:11 +0000
Subject: [lm-sensors] PATCH: abituguru driver
Message-Id: <20060526231911.9899dfe9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B10F.7070502@hhs.nl>
In-Reply-To: <4470B10F.7070502@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> This one should be it. I've converted the driver to implement the new
> sysfs alarm interface and I've created a proper patch against the latest
> mm kernel tree, including the nescesarry makefile & kconfig mods,
> MAINTAINERS entry, docs etc.
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>

OK, I applied this. At last! :)

I did many cosmetic changes, fixing coding style and spelling all
around the place.

I didn't do a full review, given that the code was already reviewed
several times. If things need to be fixed, they always can be fixed
afterwards. And this will happen ;) From now on, any further change
should be provided as an incremental patch. The exact patch I applied
can be seen here:

http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-abituguru-new-driver.patch

Now, before I push this upwards, there's at least one thing which I
would like you change/fix: the sysfs interface files handling. I see
that you are creating the sysfs file attributes dynamically, and store
the names in a large array in the device private data structure:

> struct abituguru_data {
> (...)
> 	/* The sysfs attr and their names are generated automatically, for bank1
> 	   we cannot use a predefined array because we don't know beforehand
> 	   of a sensor is a volt or a temp sensor, for bank2 and the pwms its
> 	   easier todo things the same way.  For in sensors we have 9 (temp 7)
> 	   sysfs entries per sensor, for bank2 and pwms 6. */
> 	struct sensor_device_attribute_2 sysfs_attr[16 * 9 +
> 		ABIT_UGURU_MAX_BANK2_SENSORS * 6 + ABIT_UGURU_MAX_PWMS * 6];
> 	/* Buffer to store the dynamically generated sysfs names, we need 2120
> 	   bytes for bank1 (worst case scenario of 16 in sensors), 444 bytes
> 	   for fan1-6 and 738 bytes for pwm1-6 + some room to spare in case I
> 	   miscounted :) */
> 	char bank1_names[3400];

Why do you want to do this in the first place? All other hardware
monitoring drivers use static attributes. Within a given driver, not
all supported chips use all attributes, but that's OK. What makes the
uGuru different?

Your dynamic implementation has "overflow" written on it in big block
letters. What will happen when we later need to add files? Or if we
change the names and the new ones are longer? I'd need to be convinced
that everything is safe and under control. "3400" hardcoded doesn't
qualify, let alone the comment itself ;) At the very least, you should
express the array size from clearly defined constants. And you should
use snprintf, not sprintf, when filling the array.

But before that you really need to convince me that this is needed at
all, because the code complexity must be justified by a significant
benefit, else it's just not worth it.

I won't push the driver upwards until this is sorted out.

Other cleanups I'd like you to consider:

* Use the ARRAY_SIZE macro instead of hardcoded values wherever
  possible.
* In abituguru_probe(), refactor the error path so that you have a
  single call to kfree().

Thanks,
-- 
Jean Delvare


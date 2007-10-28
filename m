From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 14:05:13 +0000
Subject: Re: [lm-sensors] PATCH: add support for lm_sensors 3.0.0 to gkrellm
Message-Id: <20071028150513.6a8f296b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <472463E8.8060109@hhs.nl>
In-Reply-To: <472463E8.8060109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 28 Oct 2007 11:26:48 +0100, Hans de Goede wrote:
> For those interested. I've made the patch so that gkrellm can be compiled 
> against the new version (or the old) and so that the identification strings of 
> the sensors do not change and thus old gkrellm configs will continue to work as is.

Random comments:

> +			snprintf(sensor_path, sizeof (sensor_path), "%s:%s",
> +				name->prefix, name->path ? name->path : "NULL");

name->path can't actually be NULL. BTW, I wonder why you need
name->path at all. This is meant for libsensors internal use,
applications shouldn't care about it. Also note that the path is not
guaranteed to be consistent across reboots.

> +			/* failsafe tests, will bus type and nr fit in 8 bits
> +			   signed and addr fit in 16 bits signed ?
> +			*/

Unfortunately not: for SPI, the bus number can require 16 bits. It's
due to the weird way spi-core uses to number buses dynamically, it
should really be addressed someday, but at the moment it isn't.

> I've also send this upstream, and its available here:
> http://people.atrpms.net/~hdegoede/gkrellm-2.3.0-libsensors4.patch

Note that I've stopped referring to "libsensors4" after I realized it
could cause confusion. While the binary file will be named
"libsensors.so.4", the library version will be advertised as
"libsensors 3.0.0". So for example I've renamed the xsensors patch to:

xsensors-0.60-libsensors-3.patch

And I suggest that you do the same. The soname is an internal detail
end users don't even need to know.

> The later is to be able to put up a link on the download page for the 3.0.0 
> RC's from the wiki, I haven't done this yet as this patch will not work with 
> rc2, it requires current svn.

rc3 is released now, so you could proceed. However you'll need special
permissions to edit the Download page. So I can either grant you these
permissions if you want, or I can add the link for you if you prefer.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

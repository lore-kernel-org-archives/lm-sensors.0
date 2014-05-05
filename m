From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 05 May 2014 17:32:31 +0000
Subject: Re: [lm-sensors] coretemp.0 folder contents changed
Message-Id: <20140505173231.GA25644@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5367C6A7.5020008@linux.intel.com>
In-Reply-To: <5367C6A7.5020008@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Mon, May 05, 2014 at 10:13:11AM -0700, Srinivas Pandruvada wrote:
> Hi,
> 
> for kernel : 3.15.rc3 .
> 
> Is there any change in the coretemp? Previously we used to see,
> tempx data (like temp2_input, temp2_max etc.)
> /sys/devices/platform/coretemp.0/.
> 
That isn't where you are supposed to look for hwmon attributes.

> Now We don't see them. Now we have to go
> /sys/devices/platform/coretemp.0/hwmon/hwmon?/ to get these values.
> 
This is also not the correct location.

You should be looking in /sys/class/hwmon/hwmonX/.

There will be a name attribute either in /sys/class/hwmon/hwmonX/name
or in /sys/class/hwmon/hwmonX/device/name. For coretemp, the value
reported in the name attribute will be 'coretemp'. This defines the
directory where the actual sensor attributes will be located.

A better approach might be to use libsensors instead of directly
accessing attributes.

To give you the background, hwmon attributes are in the process of
being moved from the parent device to the hwmon device, or from
/sys/class/hwmon/hwmonX/device/ to /sys/class/hwmon/hwmonX/,
as part of an effort to streamline the code and make it more
consistent and maintainable.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

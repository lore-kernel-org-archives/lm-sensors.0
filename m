From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Feb 2012 15:19:25 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: (hwmon-vid) Determine vrm during initialization, and add vrm
Message-Id: <20120201161925.06f7f1b0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 1 Feb 2012 06:48:54 -0800, Guenter Roeck wrote:
> Another key question: Can I remove the vrm attribute entirely from all drivers,
> and/or can I even make it read-only, without going through the feature removal 
> process ? It is documented in the ABI, and libsensors supports it.

It is documented in the ABI as an attribute which can exist, not one
which is mandatory. Thus removing it shouldn't break anything.

As far as libsensors is concerned, version from lm-sensors 3.x does
_not_ know of VRM. At all. I already did not like the implementation
back when I converted libsensors to make use of the standard sysfs
interface, so I decided to not include it :)

Version from lm-sensors 2.x does support it, but at least in the latest
version it is printed through a common helper function (print_vid_info)
which will silently skip the VRM value if not readable. So we're safe
here too.

> Maybe I should only apply the patch to hwmon-vid.c now, and schedule vrm removal
> for something like 2013 ?

I'm fine both ways, thought 2013, is probably too far away. I really
have no problem with you killing this whole legacy thing right now if
you feel like it, but if you prefer to announce it now and do it in 6
months, that's up to you really.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 18 Mar 2012 12:17:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Add support for the integrated watchdog (v2)
Message-Id: <20120318121703.GB26167@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332072308-4404-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1332072308-4404-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

On Sun, Mar 18, 2012 at 08:05:08AM -0400, Hans de Goede wrote:
> Add support for the watchdog integrated into the SMSC SCH5627 and
> SCH5636 superio-s. Since the watchdog is part of the hwmon logical device
> and thus shares ioports with it, the watchdog driver is integrated into the
> existing hwmon drivers for these.
> 
> Note that this version of the watchdog support for sch56xx superio-s
> implements the watchdog chardev interface itself, rather then relying on
> the recently added watchdog core / watchdog_dev. This is done because
> currently some needed functionality is missing from watchdog_dev, as soon
> as this functionality is added (which is being discussed on the
> linux-watchdog mailinglist), I'll convert this driver over to using
> watchdog_dev.
> 
> Changes in v2:
> -fix checkpatch complaints
> -follow multi-line comment style guidelines
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

You are too fast ;-). Unfortunately, we'll need v3, with the slab.h include.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

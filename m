From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Sep 2013 18:31:56 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/9] Introduce hwmon_device_register_with_groups and
Message-Id: <20130914203156.55e4b885@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378003742-18685-1-git-send-email-linux@roeck-us.net>
	<5224E62F.1050400@roeck-us.net>
In-Reply-To: <5224E62F.1050400@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, 02 Sep 2013 12:25:35 -0700, Guenter Roeck wrote:
> On 08/31/2013 07:48 PM, Guenter Roeck wrote:
> > This patch series introduces new hwmon API functions
> > hwmon_device_register_with_groups() and devm_hwmon_device_register_with_groups().
> >
> > hwmon_device_register_with_groups() lets callers register hwmon devices
> > as well as associated sysfs attributes with a single call. This simplifies
> > hwmon device registration and avoids potential race conditions seen
> > if sysfs attributes are created after the initial hwmon device was
> > registered.
> >
> > devm_hwmon_device_register_with_groups() is the managed version of the same
> > function.
> >
> Jean, any comments on this patch series ?
> 
> If you are ok with it, I would like to push the new API (patches 1 and 7 of the series)
> into 3.12, and keep the rest for 3.13.

I'm afraid I won't have the time to review all these patches. The
concept looks good to me and I trust that you implemented things right
so feel free to push the patches upstream even without my review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

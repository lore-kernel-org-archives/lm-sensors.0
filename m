From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 17 Feb 2016 03:37:45 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/3] Allow iio_hwmon to accept hypen in node names
Message-Id: <56C3EB09.1050803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1455597464.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1455597464.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sanchayan Maity <maitysanchayan@gmail.com>, shawnguo@kernel.org
Cc: jdelvare@suse.com, stefan@agner.ch, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 02/15/2016 09:00 PM, Sanchayan Maity wrote:
> Hello,
>
> Initial versions of the patchset intended to introduce the use of
> iio_hwmon for Vybrid SoC's. Currently the iio_hwmon driver has two
> users and as per the binding documentation, the node names use the
> underscore. Use of hypen in device tree node names is acceptable,
> however currently the hwmon core code rejects it due to perhaps user
> space not liking the hypen and getting confused.
>
> As per Guenter Roeck's suggestion, the first patch looks for a hypen
> and replaces it with a underscore in the probe call of iio_hwmon driver
> before calling hwmon_device_register_with_groups for registration. Any
> users of iio_hwmon driver can now use hypen in the node name.
>
> As per Shawn's suggestion, the existing users have been changed to use
> the hypen instead of the underscore and the iio-bindings document
> updated. Third patch introduces the usage for Vybrid itself.
>
> Patchset is based on top of shawn's for-next branch.
>
> Feedbacks and comments most welcome. Thank you for feedbacks.
>
> @Guenter
> I hope I understood and implemented correctly what you had in mind.
>
Yes.

Series applied to hwmon-next (if the dts changes also end up in an arm branch,
no harm done).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

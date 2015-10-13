From: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Date: Tue, 13 Oct 2015 22:02:47 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Bumps limit of maximum core ID from 32 to 128.
Message-Id: <D6EDEBF1F91015459DB866AC4EE162CC0231739E@IRSMSX103.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
 <20151013203134.GA28106@roeck-us.net>
In-Reply-To: <20151013203134.GA28106@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "jdelvare@suse.de" <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Phil Pokorny <ppokorny@penguincomputing.com>

On Tuesday, October 12, 2015 at 10:32 PM, Guenter Roeck wrote:
> Why 128 instead of a more reasonable 64 ? What is the required minimum
> for Xeon Phi ?

It would be fine today, but it will be not enough in 2016 and we would like to
give GNU/Linux distributions some time to propagate this patch.
For Knights Corner which is already on the market we need 61.
For Knights Landing we need 72.
For future generation it is not yet public information.

> Also, please consider using the subject line commonly used in hwmon,
> or at least point to the driver you are changing.

Right, I forgot this time, I'll send another patch just tell me whether 128
is ok, or please select any other value greater or equal known minimum
that you think will be more appropriate.

Thanks,
Lukas

 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

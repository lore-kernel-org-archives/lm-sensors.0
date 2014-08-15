From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Aug 2014 15:39:24 +0000
Subject: Re: [lm-sensors] [PATCH V3] hwmon, k10temp: Add support for F15h M60h
Message-Id: <53EE29AC.6050709@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408058127-19374-1-git-send-email-aravind.gopalakrishnan@amd.com>	<53EDE4B3.6090903@roeck-us.net>	<53EE1E04.9080406@amd.com> <CAAek22FpQRhDqjSQjOL_UfoJ51hHqbxYZu2AGTA54LRM9sFn2g@mail.gmail.com>
In-Reply-To: <CAAek22FpQRhDqjSQjOL_UfoJ51hHqbxYZu2AGTA54LRM9sFn2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Pokorny <ppokorny@penguincomputing.com>, Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: "clemens@ladisch.de" <clemens@ladisch.de>, "jdelvare@suse.de" <jdelvare@suse.de>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "bp@suse.de" <bp@suse.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 08/15/2014 08:18 AM, Phil Pokorny wrote:
>
>         On 08/14/2014 04:15 PM, Aravind Gopalakrishnan wrote:
>
>             This patch adds temperature monitoring support for F15h M60h processor.
>                - Add new pci device id for the relevant processor
>                - The functionality of REG_REPORTED_TEMPERATURE is moved to
>                  D0F0xBC_xD820_0CA4 [Reported Temperature Control]
>                  - So, use this to get CUR_TEMP value
>                  - Since we need an indirect register access, protect this with
>                    a mutex lock
>
>
> What about making this a new driver forked from k10temp.
>
> AMD has changed how they report temperatures and the very different method of getting these temps suggests that it is no longer reasonable to add support to this driver for these new chips. Particular attention to the mutex required to protect the indirect register suggests that this would benefit from focus in its own driver now that there are multiple members of the "k15temp" family.
>
> Anyone else have thoughts?
>

Everything in that new driver except for reading the actual temperature
would be exactly the same. That doesn't make sense to me.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

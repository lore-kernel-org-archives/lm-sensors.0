From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Aug 2014 10:45:07 +0000
Subject: Re: [lm-sensors] [PATCH V3] hwmon, k10temp: Add support for F15h M60h
Message-Id: <53EDE4B3.6090903@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408058127-19374-1-git-send-email-aravind.gopalakrishnan@amd.com>
In-Reply-To: <1408058127-19374-1-git-send-email-aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>, clemens@ladisch.de, jdelvare@suse.de, rdunlap@infradead.org, bp@suse.de
Cc: lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/14/2014 04:15 PM, Aravind Gopalakrishnan wrote:
> This patch adds temperature monitoring support for F15h M60h processor.
>   - Add new pci device id for the relevant processor
>   - The functionality of REG_REPORTED_TEMPERATURE is moved to
>     D0F0xBC_xD820_0CA4 [Reported Temperature Control]
>     - So, use this to get CUR_TEMP value
>     - Since we need an indirect register access, protect this with
>       a mutex lock
>   - Add Kconfig, Doc entries to indicate support for this processor.
>
> Signed-off-by: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
> ---
> Changes in V3:
>   - Move helper function that protects indirect register access locally
>     until a time when others outside k10temp may need it
>

Applied, with a small change: I made the mutex and the new function static.
That can be changed if/when needed, and declaring it static now ensures that
we'll notice it. Likely the "next" user won't use the function anyway, but
that is a problem to sort out after it happens.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 31 Jul 2014 04:43:23 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (amc6821) Fix possible race condition bug
Message-Id: <53D9C96B.1050507@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406770999.16771.1.camel@phoenix>
In-Reply-To: <1406770999.16771.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/30/2014 06:43 PM, Axel Lin wrote:
> Ensure mutex lock protects the read-modify-write period to prevent possible
> race condition bug.
> In additional, update data->valid should also be protected by the mutex lock.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Good catch.

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

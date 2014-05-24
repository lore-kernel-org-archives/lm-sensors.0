From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 24 May 2014 15:47:52 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (nct6683) Fix probe unwind paths to properly unregister platform 
Message-Id: <20140524154752.GB31881@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1400943862.14783.0.camel@phoenix>
In-Reply-To: <1400943862.14783.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 24, 2014 at 11:04:22PM +0800, Axel Lin wrote:
> Call platform_device_unregister() rather than platform_device_put() to
> unregister successfully registered platform devices.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Applied, thanks.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

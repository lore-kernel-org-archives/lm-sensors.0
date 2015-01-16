From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 16 Jan 2015 18:30:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <20150116183020.GA6262@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>
 <54B92596.2040206@roeck-us.net>
In-Reply-To: <54B92596.2040206@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Rosengren <robert.rosengren@axis.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org
Cc: Johan Adolfsson <johana@axis.com>, Robert Rosengren <robertr@axis.com>, linux-kernel@vger.kernel.org

On Fri, Jan 16, 2015 at 06:52:06AM -0800, Guenter Roeck wrote:
> On 01/16/2015 04:05 AM, Robert Rosengren wrote:
> >The default sample interval may be too slow for certain clients. This
> >patch makes it configurable via the platform_data.
> >
> >Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
> >Signed-off-by: Johan Adolfsson <johan.adolfsson@axis.com>
> 
> I am basically fine with the patch, though I would prefer replacing
> the entire update handling and chip access with regmap. Would you be
> interested in doing that ?
> 
I sent a couple of patches a minute ago which should take care of the issue.
Would be great if you can test it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

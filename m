From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Sep 2011 14:59:55 +0000
Subject: Re: [lm-sensors] hwmon and uevents
Message-Id: <1314975595.2455.54.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110901053034.GB26725@ericsson.com>
In-Reply-To: <20110901053034.GB26725@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-09-01 at 01:30 -0400, Guenter Roeck wrote:
> Hi all,
> 
> another question which just came up, somewhat related to the SYSFS question:
> 
> If and how should the hwmon subsystem support uevents ?
> 
> So far we have the gpio-fan driver which generates a generic uevent, plus we have 
> two driver submissions which if accepted would also generate uevents. The gpio uevent
> is generic, as is the omap4 driver. The EXYNOS4, however, introduces uevents
> with driver specific context information.
> 
> Couple of questions. Do we want to support uevents as a generic mechanism ? If yes,
> in what context ? In other words, independent of sysfs support, or as secondary mechanism ?
> If we do want to support uevents, do we need an ABI to standardize uevent messages ?
> 
Jean, any comments ?

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

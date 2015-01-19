From: Robert Rosengren <robert.rosengren@axis.com>
Date: Mon, 19 Jan 2015 11:14:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads7828) Make sample interval configurable
Message-Id: <4BEA3FF3CAA35E408EA55C7BE2E61D059418DD4823@xmail3.se.axis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421409922-28299-1-git-send-email-robert.rosengren@axis.com>
 <54B92596.2040206@roeck-us.net>,<20150116183020.GA6262@roeck-us.net>
In-Reply-To: <20150116183020.GA6262@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
Cc: Johan Adolfsson <johana@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> On Fri, Jan 16, 2015 at 06:52:06AM -0800, Guenter Roeck wrote:
> > I am basically fine with the patch, though I would prefer replacing
> > the entire update handling and chip access with regmap. Would you be
> > interested in doing that ?
> >
> I sent a couple of patches a minute ago which should take care of the issue.
> Would be great if you can test it.
>
> Thanks,
> Guenter

OK, great. I will look into your patch next week, since I'm currently out of office.

BR, 
Robert
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

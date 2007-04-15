From: Dmitry Torokhov <dtor@insightbb.com>
Date: Sun, 15 Apr 2007 02:07:15 +0000
Subject: Re: [lm-sensors]
Message-Id: <200704142207.16800.dtor@insightbb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070410150227.1bac05b5@hyperion.delvare> <461dca480d7ec@wp.pl> <461DDF7D.1060101@hhs.nl>
In-Reply-To: <461DDF7D.1060101@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Krzysztof Helt <krzysztof.h1@wp.pl>, "Mark M. Hoffman" <mhoffman@lightlink.com>, LKML <linux-kernel@vger.kernel.org>

Hi,

On Thursday 12 April 2007 03:27, Hans de Goede wrote:
> Krzysztof Helt wrote:
> 
> >> * Must follow kernel coding style guidelines
> > 
> > Is there any tool to check this? If there is one, a basic
> > instruction how to use it would be great.
> > 
> 
> No tool.

Passing new drivres through scripts/Lindent and analyzing the
dirrerences can highlight differences between kernel style and
author's (note that I do not advocate mechanically passing
everything though Lindent).

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

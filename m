From: Matt Roberds <mattroberds@cox.net>
Date: Mon, 20 Apr 2009 03:35:17 +0000
Subject: Re: [lm-sensors] Questions about contributing the
Message-Id: <Pine.LNX.4.64.0904192224250.8248@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090413161101.7da08473@hyperion.delvare>
In-Reply-To: <20090413161101.7da08473@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Apr 2009 16:37:30 +0900, Kim Kyuwon wrote:
> I'm thinking of contributing the kxsd9 driver (accelerometer driver)
> as Hardware Monitoring device.
>
> Before contributing, I'd like to ask:
> 1. Does it make sense to implement an accelermeter as lm-sensor
> driver?

There has been some work in this area under the title "industrialio" or
"iio" - separate from lm-sensors.  See http://lkml.org/lkml/2008/12/1/156
for a little more information.  One of the devices supported so far is
an accelerometer.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

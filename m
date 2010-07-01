From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Jul 2010 06:33:11 +0000
Subject: Re: [lm-sensors] Driver for MAX6696 temperature sensor
Message-Id: <20100701083311.1bcf22d3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100701011831.GA6915@ericsson.com>
In-Reply-To: <20100701011831.GA6915@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 30 Jun 2010 18:18:31 -0700, Guenter Roeck wrote:
> one of the hwmon drivers I'll have to write is for MAX6696. This chip is similar to lm90 / max6680,
> only it supports three temperature sensors instead of two. The two external sensors share one
> set of registers.

How does it work exactly?

> What is the better approach - write a new driver based on the lm90 driver,
> or modify the lm90 driver to support max6696 and thus optionally three channels ?
> Any thoughts ?

Both are acceptable. Best choice depends on how intrusive it is to add
support to the lm90 driver. I suspect there won't be too much to add? I
would recommend trying it, and if we finally decide it's too intrusive,
copy the lm90 driver to a new one and clean up them both.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

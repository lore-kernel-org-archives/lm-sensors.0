From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Apr 2009 14:11:01 +0000
Subject: Re: [lm-sensors] Questions about contributing the
Message-Id: <20090413161101.7da08473@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Apr 2009 16:37:30 +0900, Kim Kyuwon wrote:
> Hi Jean,
> 
> I'm thinking of contributing the kxsd9 driver (accelerometer driver)
> as Hardware Monitoring device.
> 
> Before contributing, I'd like to ask:
> 1. Does it make sense to implement an accelermeter as lm-sensor driver?

General answer is no, the hwmon interface doesn't meet the
requirements. Accelerometers are specific devices which need a
dedicated interface.

> The data-sheet is here:
> http://www.kionix.com/sensors/accelerometer-products.html
> 
> 2. Is anyone working on KXSD9?
> 
> Regards,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

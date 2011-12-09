From: Kyle Manna <kyle.manna@fuel7.com>
Date: Fri, 09 Dec 2011 06:38:01 +0000
Subject: Re: [lm-sensors] [PATCH RFC] mfd: twl4030-madc: Enable ADC channels
Message-Id: <4EE1ACC9.5000404@fuel7.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGDS+n=QJNjCyfQ2zvPweC=aBDWt=n+y1ccgTAafqJCYt991yg@mail.gmail.com>
In-Reply-To: <CAGDS+n=QJNjCyfQ2zvPweC=aBDWt=n+y1ccgTAafqJCYt991yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Sakoman <sakoman@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>

On 12/08/2011 05:13 PM, Steve Sakoman wrote:
> Currently the driver does not explicitly set the TWL4030_USB_SEL_MADC_MCPC
> bit to enable madc input channels 3 through 6.  This results in readings near
> zero for these channels since the inputs are grounded if this bit is not set.

I've run into this same problem and have fixed it the same way, looks 
good to me.

Reviewed-by: Kyle Manna <kyle@kylemanna.com>

- Kyle

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

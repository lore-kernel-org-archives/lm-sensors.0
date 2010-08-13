From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Aug 2010 16:36:02 +0000
Subject: Re: [lm-sensors] [PATCH 5/6] hwmon: (pc87427) Add temperature
Message-Id: <20100813183602.730fdbc1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811171326.230ae5fd@hyperion.delvare>
In-Reply-To: <20100811171326.230ae5fd@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 12 Aug 2010 10:37:17 -0700, Guenter Roeck wrote:
> On Wed, 2010-08-11 at 11:13 -0400, Jean Delvare wrote:
> > Add support for the 6 temperature monitoring channels of the PC87427.
> > Note that the sensors resolution can vary, and I couldn't find a way
> > to figure it out, so we might have to compensate in user-space.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> One question: You don't sign extend the 16 bit sensor data. Does that
> mean negative values will be reported as large positive values, or does
> the chip sign extend internally from 8/9 to 16 bit ?

The chip provides 16-bit values. What is 8- or 9-bit is the integer
part of the value. So there is no need to sign-extend anything. Which
is good because we don't even know for sure if the value is signed...
The driver assumes so because this is the most common for thermal
sensors, but it could be wrong for some setups. The issue we have
basically is that we don't know where the decimal point is :(

I'm glad that this is a rare chip, used only on a couple boards, so
that the pain is limited.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

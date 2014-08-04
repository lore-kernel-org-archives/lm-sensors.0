From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 04 Aug 2014 14:28:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) Prevent overflow problem when writing large limits
Message-Id: <53DF989E.8060806@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406957798.14101.1.camel@phoenix>
In-Reply-To: <1406957798.14101.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/01/2014 10:36 PM, Axel Lin wrote:
> On platforms with sizeof(int) < sizeof(unsigned long), writing a rpm value
> larger than MAXINT will result in unpredictable limit values written to the
> chip. Avoid auto-conversion from unsigned long to int to fix the problem.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Good catch. Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 31 Jul 2014 16:43:33 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (lm77) Prevent overflow problem when writing large limits
Message-Id: <53DA7235.8010504@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406818684.13799.1.camel@phoenix>
In-Reply-To: <1406818684.13799.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/31/2014 07:58 AM, Axel Lin wrote:
> On platforms with sizeof(int) < sizeof(long), writing a temperature
> limit larger than MAXINT will result in unpredictable limit values
> written to the chip.
> Clamp the input values to the supported limits first to fix the problem.
>
> For set_temp_hyst:
> As Guenter pointed out that the temperature is read as unsigned and stored in
> an unsigned long. This is wrong; nothing in the datasheet suggests that the
> value (the absolute temperature) must be positive.
> So change it to signed.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

This one passes testing. Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

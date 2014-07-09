From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jul 2014 01:34:03 +0000
Subject: Re: [lm-sensors] [RFT][PATCH v2 1/2] hwmon: (da9055) Don't use dash in the name attribute
Message-Id: <53BC9C0B.1090504@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404868974.12195.4.camel@phoenix>
In-Reply-To: <1404868974.12195.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/08/2014 06:22 PM, Axel Lin wrote:
> Dashes are not allowed in hwmon name attributes.
> So now use "da9055" instead of "da9055-hwmon" in name attribute.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Cc: stable@vger.kernel.org

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

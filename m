From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jul 2014 01:33:37 +0000
Subject: Re: [lm-sensors] [RFT][PATCH v2 1/2] hwmon: (da9052) Don't use dash in the name attribute
Message-Id: <53BC9BF1.40305@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404868739.12195.1.camel@phoenix>
In-Reply-To: <1404868739.12195.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/08/2014 06:18 PM, Axel Lin wrote:
> Dashes are not allowed in hwmon name attributes.
> So now use "da9052" instead of "da9052-hwmon" in name attribue.

s/attribue/attribute/

>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Cc: stable@vger.kernel.org

Applied.

Fyi, you don't need to send the e-mail to stable@ yourself; the tag takes care of it.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

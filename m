From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 Aug 2013 14:49:46 +0000
Subject: Re: [lm-sensors] [PATCH 0/1] hwmon: add support for tmp112
Message-Id: <52010D0A.9030804@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <28DAD847AEFDD344B2D3802E7670BEE116B9124C@DNCE04.ent.ti.com>
In-Reply-To: <28DAD847AEFDD344B2D3802E7670BEE116B9124C@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/06/2013 06:20 AM, Felten, Lothar wrote:
> This patch adds support for the tmp112 temperature sensor which is similar to the lm75 series. The driver does exploit the higher conversion time (4Hz by default)
>
Hi Lothar,

the description is kind of confusing. It suggests you had to do something special
to add support (... exploit higher conversion time ... ) for TMP112, but all
you really do is to add 'tmp112'. If nothing special has to be done, please
drop the exploit sentence, as it just adds confusion.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

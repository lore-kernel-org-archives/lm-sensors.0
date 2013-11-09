From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 09 Nov 2013 18:27:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add support for GMT G751 chip in lm75 driver
Message-Id: <20131109182707.GA19407@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <87bo1th3ul.fsf@natisbad.org>
In-Reply-To: <87bo1th3ul.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Jean Delvare <khali@linux-fr.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, Nov 09, 2013 at 06:39:14PM +0100, Arnaud Ebalard wrote:
> 
> This was tested on a NETGEAR ReadyNAS 2120 device (Marvell Armada XP
> based board, via DT).
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>

Looks good. I'll apply it to my -next branch. Since I already sent my 
pull request to Linus, this will only go in after -rc1, which I hope
should be ok (unless Jean wants to pick it up for his pull request).

> ---
> Hi Guenter,
> 
> As a side note, I removed the hunk that was present in previous patch to
> add gmt to the list of DT vendor prefixes because I noticed someone had
> taken care: https://lkml.org/lkml/2013/9/12/365
> 
> For the records, here is what I get on my NAS with the attached patch:
> 
> root@thin:/sys# sensors
> g762-i2c-0-3e
> Adapter: mv64xxx_i2c adapter
> fan1:        5461 RPM  (div = 1)
> 
> g762-i2c-0-48
> Adapter: mv64xxx_i2c adapter
> fan1:        5461 RPM  (div = 1)
> 
> g762-i2c-0-49
> Adapter: mv64xxx_i2c adapter
> fan1:        5461 RPM  (div = 1)
> 
Those rpms are pretty high. Are the fans all really running that fast ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

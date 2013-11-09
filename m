From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 Nov 2013 21:17:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add support for GMT G751 chip in lm75 driver
Message-Id: <20131109221744.488bd9ea@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87bo1th3ul.fsf@natisbad.org>
	<20131109182707.GA19407@roeck-us.net>
In-Reply-To: <20131109182707.GA19407@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnaud Ebalard <arno@natisbad.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, 9 Nov 2013 10:27:07 -0800, Guenter Roeck wrote:
> On Sat, Nov 09, 2013 at 06:39:14PM +0100, Arnaud Ebalard wrote:
> > 
> > This was tested on a NETGEAR ReadyNAS 2120 device (Marvell Armada XP
> > based board, via DT).
> > 
> > Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> 
> Looks good. I'll apply it to my -next branch. Since I already sent my 
> pull request to Linus, this will only go in after -rc1, which I hope
> should be ok (unless Jean wants to pick it up for his pull request).

No, I don't.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

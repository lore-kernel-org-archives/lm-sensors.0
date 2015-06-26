From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 26 Jun 2015 15:17:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7802) fix visibility of temp3
Message-Id: <20150626151736.GA13086@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435330064-21565-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435330064-21565-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@MakeLinux.com>
Cc: jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, const <const@ctera.com>

On Fri, Jun 26, 2015 at 05:47:44PM +0300, Constantine Shulyupin wrote:
> From: const <const@ctera.com>
> 
> Excerpt from datasheet:
> 7.2.32 Mode Selection Register
> RTD3_MD : 00=Closed , 01=Reserved , 10=Thermistor mode , 11=Voltage sense
> 
> Show temp3 only in Thermistor mode
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Thanks, applied. I'll also submit the patch to -stable releases as needed.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

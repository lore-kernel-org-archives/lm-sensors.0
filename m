From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 Jan 2015 18:21:06 +0000
Subject: Re: [lm-sensors] [PATCH v8 0/5] hwmon: ina2xx: implement chip reinitialization and add new attribute
Message-Id: <20150106182105.GA1037@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420467656-6112-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1420467656-6112-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>

On Mon, Jan 05, 2015 at 03:20:51PM +0100, Bartosz Golaszewski wrote:
> This series implements a mechanism to detect if the chip is in its POR state
> and reinitialize it if needed. It also extends the sysfs interface to make the
> driver configurable at run-time.
> 
> The shunt_resistor attribute allows to change the shunt resistance value
> at run-time in cases where ina2xx used to do the measurement isn't integrated
> with the shunt.
> 
> The avg_rate attribute allows to increase/decrease noise reduction.
> 
Patches 1-4 added to -next; please don't resend. I'll do some testing before
publishing it.

Comments to patch 5 sent out a minute ago.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

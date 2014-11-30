From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 30 Nov 2014 19:44:55 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/5] hwmon: ina2xx: bail-out from ina2xx_probe() in case of configuration
Message-Id: <547B73B7.7070806@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417082350-23470-1-git-send-email-bgolaszewski@baylibre.com> <1417082350-23470-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417082350-23470-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <jdelvare@suse.de>

On 11/27/2014 01:59 AM, Bartosz Golaszewski wrote:
> The return value of i2c_smbus_write_word_swapped() isn't checked in
> ina2xx_probe(). This leads to devices being registered even if they cannot
> be physically detected (e.g. device is not powered-up at boot-time).
>
> Even after restoring power to such device, it is left unconfigured as the
> configuration has never been actually written to the register.
>
> Error out in case of write errors in probe and notify the user.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

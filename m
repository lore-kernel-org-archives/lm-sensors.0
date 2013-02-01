From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 01 Feb 2013 21:36:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add device tree support
Message-Id: <20130201213640.GA1606@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359753502-13240-1-git-send-email-vpalatin@chromium.org>
In-Reply-To: <1359753502-13240-1-git-send-email-vpalatin@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vincent Palatin <vpalatin@chromium.org>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Olof Johansson <olofj@chromium.org>, Sameer Nanda <snanda@chromium.org>

On Fri, Feb 01, 2013 at 01:18:22PM -0800, Vincent Palatin wrote:
> Add support to instantiate LM90-compatible sensors from a device-tree
> configuration.
> When the kernel has device tree support, we avoid doing the auto-detection
> as probing the busses might mess-up sensitive I2C devices or trigger long
> timeouts on non-functional busses.
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>

Hi Vincent,

OF support for I2C devices should already work through the I2C subsystem,
without explicit driver patch.

As for the detect function, I am not entirely sure if we want or should get
rid of it just because OF is configured. That may have unintended side effects.
Either case, I would argue that if we do want to do that, it should be done
for _all_ I2C devices and not just for the lm90 driver. In other words, it
should be done in the I2C subsystem, maybe with a separate configuration option.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

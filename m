From: akpm@osdl.org (Andrew Morton)
Date: Sat, 10 Dec 2005 10:45:55 +0000
Subject: [lm-sensors] [PATCH 3/3] i386: CS5535 chip support - SMBus
Message-Id: <20051210024555.57803358.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
In-Reply-To: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Gardner <gardner.ben@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


Module symbol problems with `make allmodconfig':

*** Warning: "cs5535_gpio_base" [drivers/i2c/busses/i2c-cs5535.ko] undefined!
*** Warning: "cs5535_gpio_mask" [drivers/char/cs5535_gpio.ko] undefined!
*** Warning: "cs5535_gpio_base" [drivers/char/cs5535_gpio.ko] undefined!

Perhaps CONFIG_CS5535=m wasn't supposed to be possible?


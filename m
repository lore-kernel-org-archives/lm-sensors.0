From: Bill Gatliff <bgat@billgatliff.com>
Date: Wed, 06 Jan 2010 04:30:33 +0000
Subject: [lm-sensors] [RFC/PATCH 0/2] Updates to improve device tree support
Message-Id: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org
Cc: Bill Gatliff <bgat@billgatliff.com>

This patch series updates the pca953x GPIO driver to take advantage
of the new of_i2c_gpiochip_add() function, which registers i2c GPIO
devices with the device tree API.  These changes allow i2c-based GPIO
expanders to be properly referenced from the proper entries in a
device tree.

The of_i2c_gpiochip_add() function has been posted for review on the
linuxppc-dev mailing list.

Bill Gatliff (2):
  Use struct of_i2c_gpio_chip instead of raw struct gpio_chip
  Reorder initialization to better support device tree data

 drivers/gpio/pca953x.c |  168 +++++++++++++++++++++++++-----------------------
 1 files changed, 88 insertions(+), 80 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

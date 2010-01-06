From: Bill Gatliff <bgat@billgatliff.com>
Date: Wed, 06 Jan 2010 04:30:34 +0000
Subject: [lm-sensors] [PATCH 0/2] *** SUBJECT HERE ***
Message-Id: <1262752236-1937-2-git-send-email-bgat@billgatliff.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org
Cc: Bill Gatliff <bgat@billgatliff.com>

*** BLURB HERE ***

Bill Gatliff (2):
  Use struct of_i2c_gpio_chip instead of raw struct gpio_chip
  Reorder initialization to better support device tree data

 drivers/gpio/pca953x.c |  168 +++++++++++++++++++++++++-----------------------
 1 files changed, 88 insertions(+), 80 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

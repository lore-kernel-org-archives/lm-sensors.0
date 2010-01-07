From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Jan 2010 08:55:46 +0000
Subject: Re: [lm-sensors] [RFC/PATCH 0/2] Updates to improve device tree
Message-Id: <20100107095546.51d933af@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org

Hi Bill,

On Tue,  5 Jan 2010 22:30:33 -0600, Bill Gatliff wrote:
> This patch series updates the pca953x GPIO driver to take advantage
> of the new of_i2c_gpiochip_add() function, which registers i2c GPIO
> devices with the device tree API.  These changes allow i2c-based GPIO
> expanders to be properly referenced from the proper entries in a
> device tree.
> 
> The of_i2c_gpiochip_add() function has been posted for review on the
> linuxppc-dev mailing list.
> 
> Bill Gatliff (2):
>   Use struct of_i2c_gpio_chip instead of raw struct gpio_chip
>   Reorder initialization to better support device tree data
> 
>  drivers/gpio/pca953x.c |  168 +++++++++++++++++++++++++-----------------------
>  1 files changed, 88 insertions(+), 80 deletions(-)

This is totally off-topic for the lm-sensors mailing list, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

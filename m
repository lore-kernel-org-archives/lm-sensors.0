From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 15 Apr 2010 12:24:32 +0000
Subject: Re: [lm-sensors] [RFC PATCH] lis3: Change lis3 driver to one module
Message-Id: <20100415142432.7c6dd24c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271333702-1729-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1271333702-1729-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 15 Apr 2010 15:15:02 +0300, Samu Onkalo wrote:
> If lis3 driver is compiled as module, it consists of two modules:
> core and interface. However, both of them are mandatory for
> proper functionality. Furthermore, it is possible to keep
> /dev/freefall open and remove interface part of the driver.
> Kernel crashes when the /dev/freefall handle is closed.
> 
> Makefile is modifed so that now there is
> only one module. Filename for core part is also changed
> from lis3lv02d to lis3lv02d-core.c.
> 
> New modules:
> lis3lv02d (for hp-laptops)
> lis3lv02d_i2c for I2C connected boards
> lis3lv02d_spi for SPI connected boards.

This duplicates 11kB of binary code across 3 drivers. And you won't be
able to load more than one of them due to common symbols. So, nack.
There must be a better way to solve this problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

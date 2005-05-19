From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH 2.6] I2C: lm87 driver ported to Linux 2.6
Message-Id: <20041019213233.GA8720@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041007230420.448a438f.khali@linux-fr.org>
In-Reply-To: <20041007230420.448a438f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 19, 2004 at 02:06:23PM -0700, Jeff Oliver wrote:
> Jean,
> 
> Do you guys want drivers for other i2c devices?  I have a driver that I 
> was working on for Phillips PCA9555 i2c to gpio device.  So you think it 
> would be something people would be interested in?

Sure, send it on.

> Also, I dont think that the version of the i2c eeprom driver had the 
> code to allow writing to the eeprom.  I added to code for writing to the 
> driver for my purposes.  Would anyone like that code?

Let's see what the patch looks like.

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040210012308.GD3087@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 09, 2004 at 05:09:27PM -0800, Jon Smirl wrote:
> I see now that the usb hosts are in /sys/class/usb_host. But to be symetrical
> with USB and PCI we should have i2c-1, i2c-2, etc in /sys/bus/i2c/devices.

Again no.  See my other response to you for why.

Remember, a i2c adapter is not a i2c device.

But a USB controller does contain a USB device (at least one, usually
more than one these days) within itself.

thanks,

greg k-h

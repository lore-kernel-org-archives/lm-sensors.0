From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040212215416.GD3141@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 12, 2004 at 01:12:28PM -0800, Jon Smirl wrote:
> Would it be hard to add links like this:  /sys/class/usb_host to 
> /sys/bus/usb/host, /sys/class/i2c_adapter to /sys/bus/i2c/adapter (or host).
> Then move the 'host' entries out of /sys/class in 2.7? The links will make the
> move transparent to user space software.

I don't think you realize what you are trying to change.

Everything under /sys/class uses a struct class and a struct
class_device.

Everything under /sys/devices and /sys/bus are of type struct device.

This would be a big core change to try to do this.

As for your comment of "thousands of different busses", I don't quite
understand.  We have unique directories in /sys/class for the different
_types_ of bus hosts and classes.  If I have a box with 40,000 scsi
devices, I still only have 1 /sys/class/scsi_host directory.

If you think this is important, hey, I'm always willing to look over
patches :)

thanks,

greg k-h

From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: I2C on 2.6
Message-Id: <20040212211228.64001.qmail@web14915.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Would it be hard to add links like this:  /sys/class/usb_host to 
/sys/bus/usb/host, /sys/class/i2c_adapter to /sys/bus/i2c/adapter (or host).
Then move the 'host' entries out of /sys/class in 2.7? The links will make the
move transparent to user space software.

--- Jon Smirl <jonsmirl@yahoo.com> wrote:
> I have these buses:
> i2c                   i2c-adapter
> ide
> ieee1394
> pci                   pci_bus
> platform
> scsi                  scsi_host
> usb                  usb_host
> 
> What do you think about moving the 'host' class directories out of /class and
> into the bus directory? For example move /sys/class/usb_host to
> /sys/bus/usb/host, /sys/class/i2c_adapter to /sys/bus/i2c/adapter (or host).


==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html

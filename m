From: jonsmirl@yahoo.com (Jon Smirl)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228192735.8393.qmail@web14912.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- Jean Delvare <khali@linux-fr.org> wrote:
> As for where the code should be, I still think it is *not* possible to
> put it in the chip driver. If I understand it correctly, before the
> special sequence is send on the bus, the EDID does *not* respond to any
> I2C address. This means that the ddcmon driver will *never* be called.
> 

Am I reading this wrong? It looks to me like driver.attach_adapter,
int ddcmon_attach_adapter(struct i2c_adapter *adapter)
is always called when a bus is going to be probed.

Most of the drivers implement it like this:
int ddcmon_attach_adapter(struct i2c_adapter *adapter)
{
	return i2c_detect(adapter, &addr_data, ddcmon_detect);
}

It's then i2c_detect() that goes and looks for the devices and decides to call
ddcmon_detect(); I see that ddcmon_detect() will not be called if none of the
devices are present.

So the wakeup function can be added to the attach_adapter code. Isn't the whole
point of the attach_adapter function to allow the implementation of a custom
probing function?


==Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Get better spam protection with Yahoo! Mail.
http://antispam.yahoo.com/tools

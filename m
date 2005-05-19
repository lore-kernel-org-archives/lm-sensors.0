From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH 2.6] I2C: Add byte commands to i2c-stub
Message-Id: <20050102214101.GC17759@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041226151327.56a80b7c.khali@linux-fr.org>
In-Reply-To: <20041226151327.56a80b7c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-12-26 15:13:27 +0100]:
> Hi Mark, all,
> 
> While working on EEPROMs, DDC/EDID and the like these last few days, I
> wanted to use your i2c-stub driver to test my code. However, I noticed
> that it wouldn't handle byte commands, while both i2cdetect and the
> eeprom driver need it for proper operation. Thus I added this
> functionality to the driver. What do you think about it?
> 
> Greg, please apply to your tree unless Mark objects.

No objection here - thanks!

And since this topic has come up... I'll look into using the newly proposed
debugfs here instead of printk.  Hopefully the new usbmon [1] is a good model?

[1] http://kerneltrap.org/node/4449

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

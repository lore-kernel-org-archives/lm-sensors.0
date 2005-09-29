From: greg@kroah.com (Greg KH)
Date: Thu, 29 Sep 2005 14:03:15 +0000
Subject: [lm-sensors] Change of I2C kernel subsystem maintainer
Message-Id: <20050928200547.GA10995@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

If people hadn't noticed anymore, I've passed on the full I2C subsystem
maintainership to Jean Delvare <khali@linux-fr.org>.  He and I had been
"sharing" it for the past months, but now he's more than capable of
handling the whole thing, and I know it is in good hands now.

So, for any I2C driver questions or patches, please feel free to let him
know, don't send them to me anymore, please :)

I'll still be paying attention to the I2C core work, especially where it
touches the driver core interfaces, and have some pending work to clean
up in that area.  I'll also remain the conduit for sending I2C and hwmon
stuff on to Andrew for the -mm tree, and Linus for the mainline tree, so
nothing will change there.

thanks,

greg k-h

From: awold@bigfoot.com (Alexander Wold)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: S3Graphics Savage4 i2c driver
Message-Id: <3BDFD65B.B8327B91@bigfoot.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have recently created an i2c driver for the Savage4. It is based upon
the i2c-voodoo3 driver. The main motivation was to get access to the
bt868 connected to S3Savge4`s i2c bus. If this driver is of general
interest, I will be happy to submit it to the project. The driver is
complete, and working. There are some issues thow, i2cdump hangs the
bus, and after starting X, writes to the i2c bus don`t work. When
reloading/loading the module in X (or while x is running) it works fine.

Regards,
    Alexander Wold

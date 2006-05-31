From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Wed, 31 May 2006 12:54:33 +0000
Subject: [lm-sensors] [PATCH] Linux 2.6.16 driver for I2C based Philips
Message-Id: <20060531145433.516815a4@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF4C991ACF.DE368C38-ONC125717E.004ED613-C125717E.004FCC3D@sagemdenmark.dk>
In-Reply-To: <OF4C991ACF.DE368C38-ONC125717E.004ED613-C125717E.004FCC3D@sagemdenmark.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 May 2006 16:31:36 +0200
kim.Mostrup at sagemdenmark.com wrote:

> This patch adds support for the I2C based Philips pcf8563 RTC. It 
> basically attaches to the I2C bus and registers a RTC device which can be 
> accessed from userspace with hwclock.
> 
> It is tested on an AT91RM9200 target but the patch can be applied cleanly 
> to a 2.6.16 vanilla kernel. 
> 

 you will find a suitable driver in drivers/rtc in the latest
 .17-rcX or -mm linux tree.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it



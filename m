From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH 2.6] I2C: Add byte commands to i2c-stub
Message-Id: <20050106215418.GA27899@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041226151327.56a80b7c.khali@linux-fr.org>
In-Reply-To: <20041226151327.56a80b7c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 26, 2004 at 03:13:27PM +0100, Jean Delvare wrote:
> Hi Mark, all,
> 
> While working on EEPROMs, DDC/EDID and the like these last few days, I
> wanted to use your i2c-stub driver to test my code. However, I noticed
> that it wouldn't handle byte commands, while both i2cdetect and the
> eeprom driver need it for proper operation. Thus I added this
> functionality to the driver. What do you think about it?
> 
> Greg, please apply to your tree unless Mark objects.
> Thanks.

Applied, thanks.

greg k-h

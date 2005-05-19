From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Remove checksum code in eeprom driver
Message-Id: <20041221191007.GA8916@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041219201934.511ace3e.khali@linux-fr.org>
In-Reply-To: <20041219201934.511ace3e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 19, 2004 at 08:19:34PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> As a follow-up to my earlier proposal to remove the checksum code from
> the i2c eeprom driver, here is a patch that does just that. This shrinks
> the driver size by around 5%, and paves the way for further fixes and
> cleanups.
> 
> Please apply,

Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040116013150.GA24088@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 11, 2004 at 08:53:46PM +0100, Jean Delvare wrote:
> Here is a patch to the eeprom driver in 2.6.1 that changes the way Vaio
> eeproms are handled. In 2.6.1, the eeprom is readable only by root,
> which isn't consistent with the 2.4 driver which simple hides (i.e.
> fills it with zeroes) the first row (16 bytes) of the eeprom to regular
> users.
> 
> The patch restores a similar behaviour in the 2.6 driver. Greg, feel
> free to apply it if you like it.

Applied, thanks.

greg k-h

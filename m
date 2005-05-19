From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] I2C: Avoid repeated resets of i2c-viapro
Message-Id: <20050324000434.GD7189@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050320115744.2ac878d4.khali@linux-fr.org>
In-Reply-To: <20050320115744.2ac878d4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 20, 2005 at 11:57:44AM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> It was reported that the i2c-viapro SMBus driver sometimes has trouble
> on recent systems (VT8237 south bridge). The "Host Status" register has
> at least one additional bit used when compared with older south bridges
> of this family. The driver currently considers this additional bit as an
> error condition when it's set, causing repeated bus resets and sometimes
> read failures.
> 
> This patch makes the driver ignore the bits of the "Host Status"
> register for which no definition is known. I wish I had a datasheet for
> the VIA VT8237, so that I could check what the additional bit is
> supposed to mean, but I don't. If someone has a datasheet or good
> contacts at VIA, please let me know.
> 
> The patch was reported to fix the problem on a system with the VT8237,
> and was also tested not to break the driver on older VIA south bridges,
> so it seems to be safe. Thanks to Aurelien Jarno for the tests.
> 
> Additionally, the patch makes the post-transaction bus reset slightly
> more efficient by sparing a few unneeded I/O operations.
> 
> Please apply,


Applied, thanks.

greg k-h

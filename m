From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH 2.6] I2C: Cleanup lm78 init
Message-Id: <20040921234850.GA17372@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040921211054.3dc36a26.khali@linux-fr.org>
In-Reply-To: <20040921211054.3dc36a26.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 21, 2004 at 09:10:54PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This patch cleans the init part of the lm78 driver.
> 
> * Do not reset the chip.
> 
> * Get rid of useless code, which was accidentally left in when we
> removed the limit initialization from the driver.
> 
> * Do not enable monitoring if it is already enabled (it wouldn't hurt,
> but since we can avoid it at no cost...)
> 
> Similar changes were applied to the Linux 2.4 driver, which I
> successfully tested on my own LM78 chip.

Applied, thanks.

greg k-h

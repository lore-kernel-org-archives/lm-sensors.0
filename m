From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH 2.6] I2C: Store lm83 and lm90 temperatures in signed
Message-Id: <20040929202923.GA16608@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040926113151.298d9349.khali@linux-fr.org>
In-Reply-To: <20040926113151.298d9349.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 26, 2004 at 11:31:51AM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Back when I wrote the lm83 and lm90 drivers, I decided to use unsigned
> variables to store temperature values as mirrored from the chipset
> registers. I wonder why, since the registers use signed values
> themselves. The patch below changes the variables back to signed types,
> so as to simplify the conversions made by the driver, making them faster
> and easier to understand.
> 
> Additionally, the lm90 driver was lacking boundary checkings and proper
> rounding when writing temperature limits to the chipset, so I added
> these. I also reworded the comments about internal temperature values
> representation for all chipsets.
> 
> Tested to work fine on my (LM90-compatible) ADM1032 chip. lm83 patch
> untested, but it is more simple and directly copied from the lm90, so I
> am confident it works fine too.
> 
> Please apply,

Applied, thanks.

greg k-h

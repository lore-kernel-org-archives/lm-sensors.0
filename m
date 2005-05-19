From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH 2.6] I2C: update the lm83 driver
Message-Id: <20040809180321.GA20302@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040808221739.07e433f9.khali@linux-fr.org>
In-Reply-To: <20040808221739.07e433f9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 09, 2004 at 07:53:10PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Same player shoot again, 256 is not 0xFF but 0x100... Shame on me. Since
> both TEMP_FROM_REG and TEMP_TO_REG had the same error, it wouldn't show,
> until I happened to re-read the code. Sorry for the noise. So this patch
> replaces the previous one.

Oops, I already applied the previous one :(

Care to send me just a fix against the previous patch instead?

thanks,

greg k-h

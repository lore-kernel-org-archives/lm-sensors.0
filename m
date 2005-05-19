From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH 2.6] I2C: lm87 driver ported to Linux 2.6
Message-Id: <20041019222727.GB9521@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041007230420.448a438f.khali@linux-fr.org>
In-Reply-To: <20041007230420.448a438f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 07, 2004 at 11:04:20PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This is my port of the lm87 driver to Linux 2.6. It is based on the
> preliminary work of Jeff Oliver. I then significantly improved the code,
> added functionality, tested the whole thing on a real motherboard, fixed
> a couple remaining bugs, and here we are.
> 
> I'll port a number of improvements and fixes back to the 2.4 version of
> the driver after lm_sensors 2.8.8 is released (i.e. soon).
> 
> Please apply,

Applied, thanks.

greg k-h

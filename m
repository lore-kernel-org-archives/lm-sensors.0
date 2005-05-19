From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] atxp1 I2C kernel driver
Message-Id: <20050502201358.GA5938@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4252B62F.3050802@hasw.net>
In-Reply-To: <4252B62F.3050802@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 05, 2005 at 06:00:47PM +0200, Sebastian Witt wrote:
> 
> This driver allows to set the the VID on some platforms.
> 
> The patch is against linux-2.6.11-rc4-mm1, the patch for i2c-vid.h is
> also included to support VID register calculation for the atxp1 driver.
> 
> Signed-off-by: Sebastian Witt <se.witt@gmx.net>

Applied, thanks.  I also changed the driver a bit so that all functions
are marked static, which is what is needed.

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595 (resubmit)
Message-Id: <20050217222549.GF21188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050206202641.GA31771@bode.aurel32.net>
In-Reply-To: <20050206202641.GA31771@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aur?lien Jarno <aurelien@aurel32.net>, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 09:26:41PM +0100, Aur?lien Jarno wrote:
> Hi Greg,
> 
> Please find below the new version of the patch against kernel
> 2.6.11-rc3-mm1 to add the sis5595 driver (sensor part).
> 
> As you suggested, I have changed the PCI part of the driver, taking the
> via686a driver as an example. I have also changed the comparison of 
> jiffies by using time_after.

Applied, thanks.

greg k-h

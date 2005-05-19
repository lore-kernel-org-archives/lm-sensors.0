From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Fix DS1621 detection
Message-Id: <20050119232253.GA5909@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050119202749.GA19261@bode.aurel32.net>
In-Reply-To: <20050119202749.GA19261@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aur?lien Jarno <aurelien@aurel32.net>, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 09:27:49PM +0100, Aur?lien Jarno wrote:
> Hi Greg,
> 
> Dallas Semiconductors as recently changed the design of their DS1621
> chips, including the bits that were checked in the kernel driver to 
> detect it.
> 
> The patch below fixes the detection by checking an other bit of the
> configuration register instead.
> 
> Please apply.

Applied, thanks.

greg k-h

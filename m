From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH 2.6] I2C: update the lm83 driver
Message-Id: <20040809174123.GC2344@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040808221739.07e433f9.khali@linux-fr.org>
In-Reply-To: <20040808221739.07e433f9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 08, 2004 at 10:17:39PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This is an update to the Linux 2.6 lm83 hardware monitoring driver.
> 
> * Follow the sysfs interface naming conventions.
> * Fix the "force" module parameter.
> * Fix limit settings checks.
> * Driver is no longer tagged experimental.
> 
> These changes are the result of me finally succeeding in getting my LM83
> evaluation board to work. If there are norms and standards about how
> evaluation boards can be wired, I guess I did not respect any of them,
> but it works ;)
> 
> Please apply,

Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.6] lm83 driver updates
Message-Id: <20031230200620.GD3163@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230190618.729e1c47.khali@linux-fr.org>
In-Reply-To: <20031230190618.729e1c47.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 30, 2003 at 07:06:18PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here is a patch for the lm83 driver, to be applied on top of your
> pending patches stack. What it does:
> * Remove limit initialisation by the driver. This is a backport from
>   CVS.
> * A few whitespace changes inspired by my recent porting of the lm90
>   driver.

Applied, thanks.

greg k-h

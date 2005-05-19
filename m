From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] i2c-vid.h: Support for VID to reg conversion 2
Message-Id: <20050502210948.GB27708@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050412163404.GA14857@kroah.com>
In-Reply-To: <20050412163404.GA14857@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 13, 2005 at 10:25:39PM +0200, Sebastian Witt wrote:
> 
> Adds conversion from VID (mV) to register value. Used by the atxp1 I2C 
> module.
> Removed uneeded switch case.
> 
> Signed-off-by: Sebastian Witt <se.witt@gmx.net>

Wow, that's a messed up patch.  I fixed it up by hand and applied it.

thanks,

greg k-h

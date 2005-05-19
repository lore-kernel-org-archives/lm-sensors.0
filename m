From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: pcf8574 doesn't need a lock
Message-Id: <20050328221146.GD4495@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050328211632.656659fe.khali@linux-fr.org>
In-Reply-To: <20050328211632.656659fe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 28, 2005 at 09:16:32PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> While investigating the i2c chips drivers that were not properly
> locking, we found that the pcf8574 driver does the exact contrary. It
> uses a lock where it's not needed.
> 
> While we were there, we did some additional cleanups to the driver:
> 1* Merge pcf8574_update_client() in show_read(), as it was the only user
> and the function became trivial once the locking was removed.
> 2* Add a validity check on values provided by user-space.
> 
> Aurelien Jarno tested the modified code for confirmation and it worked
> just fine.
> 
> Please apply,


Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Refactor swap_bytes in i2c chip drivers
Message-Id: <20040329192939.GA1744@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329212303.2b47b12d.khali@linux-fr.org>
In-Reply-To: <20040329212303.2b47b12d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 29, 2004 at 09:23:03PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This simple patch refactors the swap_bytes function that various chip
> drivers use. I moved it to lm75.h because all drivers using lm75-like
> temperature sensors will most necessarily need to swap bytes.
> 
> Apply if you like it,

Ick, no, we should be using the proper kernel call for this, swab16(),
right?  Care to redo this patch to just fix the drivers and get rid of
our duplicating of this function.

thanks,

greg k-h

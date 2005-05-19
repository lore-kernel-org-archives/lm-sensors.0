From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: Move functionality handling from i2c-core to
Message-Id: <20050328221127.GC4495@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050328203853.4bf25f79.khali@linux-fr.org>
In-Reply-To: <20050328203853.4bf25f79.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 28, 2005 at 08:38:53PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> So far, the functionality handling of i2c adapters was done in i2c-core
> by two exported functions: i2c_get_functionality and
> i2c_check_functionality. I found that both functions could be reduced to
> one line each, and propose that we turn them into inline function in the
> i2c.h header file, much like other i2c helper functions (e.g.
> i2c_get_clientdata, i2c_set_clientdata and i2c_clientname).
> 
> The conversion of i2c_get_functionality suppresses a legacy check which
> shouldn't be needed anymore. Only one driver (s3c2410) was still relying
> on it, and was fixed some days ago.
> 
> The conversion lets us get rid of two exports. Not only i2c-core gets
> smaller (by 458 bytes), but the client drivers using these functions get
> smaller too (typically by 48 bytes). And of course the new way is likely
> to be faster too, even if it wasn't my primary objective.


Applied, thanks.

greg k-h

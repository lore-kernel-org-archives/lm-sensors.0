From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH 2.6] I2C: via686a cleanups
Message-Id: <20050406190040.GA30839@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050402204447.3d2b7644.khali@linux-fr.org>
In-Reply-To: <20050402204447.3d2b7644.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 02, 2005 at 08:44:47PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Here comes a small cleanup patch for the via686a driver. I noticed the
> following two non-fatal problems:
> 
> 1* The device parent is explicitely set, but it's not needed because the
> i2c core will do as the client is registered.
> 
> 2* snprintf is used where strlcpy would suffice.
> 
> Fixing them brings the via686a driver in line with what other similar
> drivers do.
> 
> Please apply,

Applied, thanks.

greg k-h

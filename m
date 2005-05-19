From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH 2.6] I2C: Kill address ranges in non-sensors i2c chip
Message-Id: <20050406185814.GA30789@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050402184103.6048d243.khali@linux-fr.org>
In-Reply-To: <20050402184103.6048d243.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 02, 2005 at 08:31:02PM +0200, Jean Delvare wrote:
> [Once again, this time *with* the signed-off-by line...]
> 
> Hi Greg,
> 
> Some months ago, you killed the address ranges mechanism from all
> sensors i2c chip drivers (both the module parameters and the in-code
> address lists). I think it was a very good move, as the ranges can
> easily be replaced by individual addresses, and this allowed for
> significant cleanups in the i2c core (let alone the impressive size
> shrink for all these drivers).
> 
> Unfortunately you did not do the same for non-sensors i2c chip drivers.
> These need the address ranges even less, so we could get rid of the
> ranges here as well for another significant i2c core cleanup. Here comes
> a patch which does just that. Since the process is exactly the same as
> what you did for the other drivers set already, I did not split this one
> in parts.
> 
> A documentation update is included.
> 
> The change saves 308 bytes in the i2c core, and an average 1382 bytes
> for chip drivers which use I2C_CLIENT_INSMOD, 126 bytes for those which
> do not.
> 
> This change is required if we want to merge the sensors and non-sensors
> i2c code (and we want to do this).
> 
> Please apply,
> thanks.

Applied, thanks.

greg k-h

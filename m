From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 2.6] I2C: Reduce it87 i2c address range
Message-Id: <20050125062740.GC2361@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050122163704.7be2c29f.khali@linux-fr.org>
In-Reply-To: <20050122163704.7be2c29f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 22, 2005 at 04:37:04PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> IT87xxF chips were never seen at any other I2C address than the default
> (0x2d) so I think that we could safely reduce the range of addresses the
> it87 drivers accepts. Currently it accepts 0x20-0x2f, I believe that
> 0x28-0x2f would already be more than sufficient.
> 
> (In theory, any address is possible, so whatever range we choose is
> arbitrary anyway.)
> 
> Please apply,

Applied, thanks.

greg k-h

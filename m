From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PATCH] I2C: rename in0_ref to cpu0_vid
Message-Id: <20040825193501.GC8261@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040812224551.712f8b5e.khali@linux-fr.org>
In-Reply-To: <20040812224551.712f8b5e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 12, 2004 at 10:45:51PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This patch changes all the i2c chip drivers and documentation to use the
> name "cpu0_vid" instead of "in0_ref". The name "in0_ref" was an error in
> the first place as motherboard manufacturers may fail to follow the chip
> manufacturer's recommendation about which "in" channel to use for VCore
> monitoring.
> 
> The new name leaves room for chips able to monitor more than 1 vid
> value, such as the LM93 and, to a lesser extent, the PC87360 family (all
> by National Semiconductor). These chips are typically designed for
> dual-CPU motherboards.
> 
> This breaks the interface (obviously) so libsensors has been updated to
> support both names.
> 
> Please apply,

Applied, thanks.

greg k-h

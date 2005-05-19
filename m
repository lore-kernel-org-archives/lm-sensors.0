From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH 2.6] I2C: Merge unused address lists in some video drivers
Message-Id: <20050406185840.GB30789@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050402200441.7bf7a310.khali@linux-fr.org>
In-Reply-To: <20050402200441.7bf7a310.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 02, 2005 at 08:04:41PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> On top of my previous patch which removes the use of address ranges in
> video i2c drivers, this one can save an additional few bytes of memory.
> Most of these drivers which do not use I2C_CLIENT_INSMOD initialize the
> unused address lists in a less than optimal way. This patch simply
> optimizes this, by using a single one-element list instead of 3
> different lists with two elements each.
> 
> This saves an average 63 bytes on these drivers.

Applied, thanks for doing this and the other address range work.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH 2.6] Fix bus reset in i2c-philips-par
Message-Id: <20040124011433.GC25072@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040123213024.79b69112.khali@linux-fr.org>
In-Reply-To: <20040123213024.79b69112.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 23, 2004 at 09:30:24PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch fixes the bus reset in i2c-philips-par when it is loaded with
> type!=0. For now, the reset is always made as is type=0. I guess that
> this driver will be abandoned in a while, but it probably doesn't hurt
> to fix that.

Applied, thanks.

greg k-h

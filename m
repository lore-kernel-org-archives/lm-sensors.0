From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] Another oops in i2c-core with debug
Message-Id: <20040224002734.GF24225@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040222132611.57e9faa7.khali@linux-fr.org>
In-Reply-To: <20040222132611.57e9faa7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com
Cc: LKML <linux-kernel@vger.kernel.org>

On Sun, Feb 22, 2004 at 01:26:11PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Some times ago, you fixed an oops in i2c-core when debugging is enabled:
> http://marc.theaimsgroup.com/?l=linux-kernel&m7585749612115&w=2
> 
> Looks like you missed that second one:

Applied, thanks.

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH 2.6] Error paths in it87 and via686a drivers
Message-Id: <20040412232228.GB26817@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040410172219.06b2ee65.khali@linux-fr.org>
In-Reply-To: <20040410172219.06b2ee65.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 10, 2004 at 05:22:19PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Here comes the patch that fixes error paths in the it87 and via686a
> detection functions. The it87 part also adds missing error values.
> 
> Please apply (on top of the big kmalloc patch),

Applied, thanks.

greg k-h

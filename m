From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH] I2C-MPC: use wait_event_interruptible_timeout between
Message-Id: <20050114184146.GA30093@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0501131816260.27470@blarg.somerset.sps.mot.com>
In-Reply-To: <Pine.LNX.4.61.0501131816260.27470@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kumar Gala <galak@somerset.sps.mot.com>
Cc: linuxppc-embedded@ozlabs.org, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 06:21:54PM -0600, Kumar Gala wrote:
> Use wait_event_interruptible_timeout so we dont waste time waiting between 
> transactions like we use to.  Also, we use the adapters timeout so the 
> ioctl cmd I2C_TIMEOUT will now work.

Applied, thanks.

greg k-h

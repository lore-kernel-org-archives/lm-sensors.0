From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH] I2C-MPC: use wait_event_interruptible_timeout
Message-Id: <20050113233616.GB2710@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0501131647540.26980@blarg.somerset.sps.mot.com>
In-Reply-To: <Pine.LNX.4.61.0501131647540.26980@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 13, 2005 at 04:50:52PM -0600, Kumar Gala wrote:
> I've changed the i2c-mpc.c driver to use wait_event_interruptible_timeout
> 
> Can you take a look and let me know if this looks good.  I'm going to have 
> some other changes to the driver to handle moving it from an OCP based 
> driver to using platform_device.

Looks sane to me.  You've tested this out?  If you're comfortable with
it, care to resend it with a "Signed-off-by:" line to me so I can apply
it to the kernel tree?

thanks,

greg k-h

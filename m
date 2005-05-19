From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <20041215194005.GB10319@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101807766.3215.103.camel@icampbell-debian>
In-Reply-To: <1101807766.3215.103.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 07, 2004 at 11:19:02AM +0000, Ian Campbell wrote:
> On Tue, 2004-12-07 at 11:42 +0100, Jean Delvare wrote:
> > Hi Ian,
> > 
> > > - printk(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
> > > + DEB1(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
> > 
> > Doesn't look OK to me. Either this is an error and it has to be
> > displayed regardless of DEBUG being enabled or not, or it is a debugging
> > info and it should use KERN_DEBUG instead of KERN_ERR. In the latter
> > case, I can already hear Greg suggest you should use pr_debug or even
> > dev_dbg instead of printk.
> 
> I think it can be considered a debug statement since I am reasonably
> sure that it is a situation which cannot arise. I've only ever seen the
> error with a pre-release of a slave part on the bus. The slave's i2c
> implementation was fairly buggy, it ignored stop bits and hung the bus
> if you sent it a duff command. The next rev of this particular slave
> device shouldn't have this problem and I certainly wouldn't expect it in
> released silicon.
> 
> If it turns out that in practise (with production slave devices) we can
> find that we hit this check then it would make sense to loop for a bit
> until the bus becomes idle or we timeout. However I'd rather see it
> happen with a production slave device before doing that. 
> 
> I've changed it to dev_dbg.
> 
> Signed-off-by: Ian Campbell <icampbell@arcom.com>

Applied, thanks.

greg k-h

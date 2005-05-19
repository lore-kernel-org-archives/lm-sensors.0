From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [PATCH 2.6] I2C: use chip driver name to request regions
Message-Id: <20041215194033.GC10319@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041210205547.1fc6299f.khali@linux-fr.org>
In-Reply-To: <20041210205547.1fc6299f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 10, 2004 at 08:55:47PM +0100, Jean Delvare wrote:
> Hi Domen,
> 
> > Trivial patch against 2.6.10-rc3-bk2.
> > When request_region is called name is set to "", use module name.
> 
> Correct. I even think we should do the same for other chip drivers. For
> now they all use an arbitrary string. Using the driver's name would be
> both more consistent and more efficient (spares some bytes of memory).
> 
> Greg, how does it look?

Applied, thanks.

> (Note that my patch does NOT include Domen's one, which would have to be
> applied separately.)

If he sent it to me, it would be :)

thanks,

greg k-h

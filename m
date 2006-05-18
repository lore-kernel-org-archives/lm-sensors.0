From: greg@kroah.com (Greg KH)
Date: Thu, 18 May 2006 20:37:49 +0000
Subject: [lm-sensors] [PATCH] OpenCores I2C bus driver
Message-Id: <20060518203749.GA30427@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <874q0n1505.fsf@sleipner.barco.com>
In-Reply-To: <874q0n1505.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 18, 2006 at 07:18:58PM +0200, Peter Korsgaard wrote:
> >>>>> "Rudolf" = Rudolf Marek <r.marek at sh.cvut.cz> writes:
> 
> Hi,
> 
>  Rudolf> Sorry for delay we all had lot of other stuff to do. I
>  Rudolf> checked your driver and it seems very good. Please check my
>  Rudolf> comments in the code.
> 
> No problem, I've had a busy week as well..
> 
> Perhaps worth noticing: This is not the latest version of the
> patch. Andrew added it to -mm after I posted it and a few small
> fixes/cleanups were done. On the 27th of April it was forwarded to
> Greg and dropped from -mm.
> 
> I'm afraid I've lost track of it since :/ I expect Greg to wait until
> 2.6.17 gets released before pushing it upstream, but I don't see it in
> his git tree..
> 
> Greg, where are you hiding it? ;)

Unless Jean sent it to me, I'm not taking i2c patches, as he is the
maintainer and I am merely the conduit to Linus and Andrew.

thanks,

greg k-h


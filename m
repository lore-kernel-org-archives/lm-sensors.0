From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH][2.5] Support for W83627THF sensor chip (Was Re: [2.5]
Message-Id: <20030618174924.GB1666@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055807044.7227.7.camel@nosferatu.lan>
In-Reply-To: <1055807044.7227.7.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 17, 2003 at 04:03:50AM +0200, Martin Schlemmer wrote:
> > So my preference is to limit the additions to w83781d.
> > 
> > There's no plans to split the existing w83781d driver.
> > We don't rename existing drivers because of CVS limitations and
> > wanting to minimize changes for our users.
> > 
> 
> Right, but what about 2.5 side ?  Will patches to do this in 2.5
> be considered ?

Sure, I'm always willing to take patches to fix things.
The kernel tree doesn't have the CVS limitations at all, so feel free to
split things up, or rename the driver if you need to :)


thanks,

greg k-h

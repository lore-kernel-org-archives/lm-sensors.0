From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Add ported sensor chip driver: asb100
Message-Id: <20040114190813.GD6107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040106051203.GK30841@earth.solarsys.private>
In-Reply-To: <20040106051203.GK30841@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 13, 2004 at 11:04:56PM -0500, Mark M. Hoffman wrote:
> * Jean Delvare <khali@linux-fr.org> [2004-01-09 22:58:58 +0100]:
> 
> > Shouldn't the asb100 be listed first, the same way the w83781d is, since
> > it has subclients? I would even put asb100 before w83781d, since for now
> > the w83781d driver will try to handle ASB100 chips too, thus preventing
> > the asb100 driver from being used if both drivers are built-in.
> 
> You're right, thanks.  Greg, please apply...
> 
> * * * * *
> 
> This patch fixes the link order for asb100 sensors chip driver.

Applied, thanks.

greg k-h

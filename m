From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors2/kernel/busses i2c-i810.c i2c-savage4.c i2c-voodoo3.c
Message-Id: <20030922210958.GA31930@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030922044140.GA17134@earth.solarsys.private>
In-Reply-To: <20030922044140.GA17134@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 22, 2003 at 12:41:40AM -0400, Mark M. Hoffman wrote:
> * author@mordac.netroedge.com <author@mordac.netroedge.com> [2003-09-21 21:55:10 -0700]:
> > Update of /home/cvs/lm_sensors2/kernel/busses
> > In directory mordac.netroedge.com:/tmp/cvs-serv25085
> > 
> > Modified Files:
> > 	i2c-i810.c i2c-savage4.c i2c-voodoo3.c 
> > Log Message:
> > (mmh) Use readl/writel for portable access to PCI memory
> 
> Testers?  I don't have any of this H/W...

At first glance this looks correct.  I'll go add this to the 2.6 tree to
get some more testers out there :)

thanks,

greg k-h

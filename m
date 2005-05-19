From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: EMC6D100 ([PATCH] for 2.6.X lm85 driver)
Message-Id: <20050112181953.GA10285@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050112175058.GA16724@penguincomputing.com>
In-Reply-To: <20050112175058.GA16724@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 12, 2005 at 09:50:58AM -0800, Justin Thiessen wrote:
> On Wed, Jan 12, 2005 at 07:30:52AM -0200, Rafael ?vila de Esp?ndola wrote:
> > Attached is a patch to add support for the EMC6D100 in the 2.6.9 kernel. I did 
> > it by following the changes that were made to the cvs lm_sensors2 to add 
> > support for the same chip.
> > 
> > It works for me on a d865glc.
> 
> Hi,
> 
> Jean - perhaps you and/or Greg can take a quick look at this.  I pulled it down
> and successfully patched/compiled the driver under a 2.6.10-bk14 tree.  Since
> I do not have access to the EMC6D100, it would be nice to get the patch from
> someone who *does* and can test such.

Looks sane, but I also do not have that hardware :(

thanks,

greg k-h

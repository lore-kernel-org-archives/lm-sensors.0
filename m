From: mchehab@brturbo.com.br (Mauro Carvalho Chehab)
Date: Thu, 27 Oct 2005 16:53:31 +0000
Subject: [lm-sensors]
Message-Id: <1130424748.6751.49.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Em Qua, 2005-10-26 ?s 13:39 -0700, Greg KH escreveu:
> On Wed, Oct 26, 2005 at 06:15:44PM -0200, Mauro Carvalho Chehab wrote:
> > Greg,
> > 
> > 	Please don't send this patch to Andrew or mainstream. I'll apply it on
> > my tree and I will send it at the end my patchset series, for not
> > breaking these.
> > 
> > 	I have several patches that are including newer IDs on
> > linux/media/i2c-id.h and I'm just preparing a patch, on V4L tree, to
> > remove this file from kernel.
> 
> But we are removing this file, as it's just not needed.  Why would you
> add more ids to it?
Greg, 
	We had included some newer IDs on our old media/id.h for some newer
drivers during development on V4L tree, that should also be moved to
linux/i2c-id.h, before removing media/id.h.
	I'm working on this patch already. After it, we will stop using the old
media/id.h, using linux/i2c-id.h instead.
> 
> thanks,
> 
> greg k-h
> 
Cheers, 
Mauro.


From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Message-Id: <20050511070534.GA10194@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670505070621784dbd63@mail.gmail.com> <20050510221615.GA4613@kroah.com> <20050511075100.A20000@flint.arm.linux.org.uk>
In-Reply-To: <20050511075100.A20000@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>, Dmitry Torokhov <dtor_core@ameritech.net>, Jean Delvare <khali@linux-fr.org>, LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 07:51:00AM +0100, Russell King wrote:
> On Tue, May 10, 2005 at 03:16:15PM -0700, Greg KH wrote:
> > +#define __ATTR(_name,_mode,_show,_store) {	\
> > +	.attr = {				\
> > +		.name = __stringify(_name),	\
> > +		.mode = _mode,			\
> > +		.private = NULL,		\
> 
> We don't specifically initialise elements to NULL or zero.  Is this a
> change of policy?

Doh, no, it isn't, you are correct.  I've updated the patch, removing
the changes to the __ATTR() and other macro that I modified.

Thanks for catching this.

greg k-h

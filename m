From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-Id: <1054706250.5268.79.camel@workshop.saharacpt.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <1054617753.5269.44.camel@workshop.saharacpt.lan>
	 <3EDCFA7B.4030906@penguincomputing.com>
In-Reply-To: <3EDCFA7B.4030906@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philip Pokorny <ppokorny@penguincomputing.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@Stimpy.netroedge.com>

On Tue, 2003-06-03 at 21:43, Philip Pokorny wrote:
> Martin Schlemmer wrote:
> > On Mon, 2003-06-02 at 19:20, Greg KH wrote:
> > 
> > Hiya Greg
> > 
> > While sorda on the topic ... since I did the w83781d driver some time
> > ago, I changed boards for a P4C800 (Intel 875 chipset), that have a
> > ICH5 southbridge, and not a ICH4 one ....  I tried to add the ID's
> > to the i810 driver, and although it does load (even without the
> > ID's added), the I2C bus/sensor does not show in /sys.  The w83781d
> > driver also load fine btw.
> 
> My system (SuperMicro) with an '875 and ICH5 reports the ICH5 as an 
> '801EB' which means you should be using the i2c-i801 driver not i2c-i810...
> 

Right ... at work, so could not verify.

> I'm also betting that you need to set 'isich4' to true in the case of 
> the ich5 as well...
> 
> Try the attached patch...  NOTE: I have *not* consulted the Intel DOC's 
> on the ICH4 and ICH5 to see if the register interface has changed in 
> other interesting ways...
> 

Will let you know, thanks.


Regards,

-- 
Martin Schlemmer


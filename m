From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: OOPS w83781d during rmmod (2.5.70-bk1[1234])
Message-Id: <1055310242.5280.1564.camel@workshop.saharacpt.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
	 <1055224269.5280.217.camel@workshop.saharacpt.lan>
In-Reply-To: <1055224269.5280.217.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@Stimpy.netroedge.com>

On Tue, 2003-06-10 at 07:51, Martin Schlemmer wrote:
> On Tue, 2003-06-10 at 07:41, Mark M. Hoffman wrote:
> > * Martin Schlemmer <azarah@gentoo.org> [2003-06-09 07:34:30 +0200]:
> > > 
> > > Anyhow, Only change I have made to the w83781d driver, is one line
> > > (just tell it to that if the chip id is 0x72, its also of type
> > > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > > it did not with 2.5.68 kernels when I still had the other board.  I will
> > > attach a oops tomorrow or such when I get home.
> > 
> > I reproduced the segfault here.  It looks like i2c_del_driver() tries
> > to call w83781d_detach_client() more than once now, partly because of
> > the safe list fix in 2.5.70-bk11.  But that function should only be
> > called for the "primary" client, not the subclients.
> > 
> > The quick/ugly patch below fixes the symptom, but maybe not the disease.
> > There might be more fundamental brokenness in the whole subclient scheme.
> > I'll keep looking when I get the chance.
> > 
> 

Nope, It does not fix it.  It basically happens when i2c_del_driver is
called for w83781d_driver.  I did add a few printk's, but it do not
seem to be anything that w83781d_detach_client does.  Rather, it
looks to be while i2c_del_driver is walking the clients for the
adapter, after it ran w83781d_detach_client for the chip (and not the
two clients).  I am assuming it grabs the client for the main chip,
calls w83781d_detach_client which then in turn free all the memory for
the main client and the two lm75 clients, return, and then check the
next client for the adapter, which happens to be one of the lm75 clients
for who we already freed the structures ....

I hope that was sort of comprehensible.  Anyhow, I will poke at it more
tonight, if thoughts, let me know.


Regards,

-- 
Martin Schlemmer


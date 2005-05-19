From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: OOPS w83781d during rmmod (2.5.70-bk1[1234])
Message-Id: <1055224269.5280.217.camel@workshop.saharacpt.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
In-Reply-To: <20030610054107.GA22719@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@Stimpy.netroedge.com>

On Tue, 2003-06-10 at 07:41, Mark M. Hoffman wrote:
> * Martin Schlemmer <azarah@gentoo.org> [2003-06-09 07:34:30 +0200]:
> > 
> > Anyhow, Only change I have made to the w83781d driver, is one line
> > (just tell it to that if the chip id is 0x72, its also of type
> > w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> > it did not with 2.5.68 kernels when I still had the other board.  I will
> > attach a oops tomorrow or such when I get home.
> 
> I reproduced the segfault here.  It looks like i2c_del_driver() tries
> to call w83781d_detach_client() more than once now, partly because of
> the safe list fix in 2.5.70-bk11.  But that function should only be
> called for the "primary" client, not the subclients.
> 
> The quick/ugly patch below fixes the symptom, but maybe not the disease.
> There might be more fundamental brokenness in the whole subclient scheme.
> I'll keep looking when I get the chance.
> 

Ok, I will give it a go tonight.  I already sent the oops to the
list before reading this if need be ...


Regards,

-- 
Martin Schlemmer


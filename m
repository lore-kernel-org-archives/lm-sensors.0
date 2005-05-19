From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH] automatic VRM detection part2
Message-Id: <20040805042341.GC4844@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0407221043150.6769@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0407221043150.6769@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-08-04 10:36:23 +0200]:
> > One small comment:
> > 
> > > @@ -959,7 +956,7 @@
> > > 
> > >  	vid = asb100_read_value(client, ASB100_REG_VID_FANDIV) & 0x0f;
> > >  	vid |= (asb100_read_value(client, ASB100_REG_CHIPID) & 0x01) << 4;
> > > -	data->vrm = ASB100_DEFAULT_VRM;
> > > +	data->vrm = i2c_which_vrm();
> > >  	vid = vid_from_reg(vid, data->vrm);
> > > 
> > >  	/* Start monitoring */
> > 
> > Why not this instead?  E.g.
> > 
> > 	if (!(data->vrm = i2c_which_vrm()))
> > 		data->vrm = ASB100_DEFAULT_VRM;
> > 
> > That way, non x86 or some x86 that isn't recognized might fall back
> > and still get it right, or at least work the same as it used to.
> 
> Unsupported CPUs are rather unlikely to use VRM 9.0

.. assuming we have a complete list, yes.

> (ASB100_DEFAULT_VRM), so in most cases it won't help. If we want to
> default to something, we would certainly default to the same VRM version
> for all drivers, and set this default version to the latest known
> version (10.0 as of now). But even then the chances that it'll work out
> of the box are slim.

True and true.

> So I think it makes more sense to clearly show that we do not support a
> given CPU yet, so that:
> 1* People can report to us.
> 2* Userspace knows it shouldn't trust the (zero) VID value.
> 
> At any rate, if we decide we want to default to something in this case,
> then let's default to the same VRM version for all drivers, being the
> VRM we consider is the more likely to be correct for unknown (i.e.
> recent) CPUs, and have the mechanism placed in i2c_which_vrm() itself
> rather than ranging all over the various drivers.
> 
> But I like it the way Ruik proposed.

OK, I have no strong objection to the patch as-is... just thought
I'd ask though.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

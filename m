From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 24 Jun 2007 13:27:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add SCH5317 to smsc47b397 driver
Message-Id: <20070624132744.GB3289@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706201541s2416f573o74e8a34fab258d3a@mail.gmail.com>
In-Reply-To: <191fb4ca0706201541s2416f573o74e8a34fab258d3a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Juerg:

> On Wed, 20 Jun 2007 15:41:33 -0700, Juerg Haefliger wrote:
> > @@ -322,7 +322,8 @@ static int __init smsc47b397_find(unsign
> >  
> >  	printk(KERN_INFO "smsc47b397: found SMSC %s "
> >  		"(base address 0x%04x, revision %u)\n",
> > -		id = 0x81 ? "SCH5307-NS" : "LPC47B397-NC", *addr, rev);
> > +		id = 0x81 ? "SCH5307-NS" : id = 0x85 ? "SCH5317" : 
> > +	       "LPC47B397-NC", *addr, rev);

* Jean Delvare <khali@linux-fr.org> [2007-06-24 12:19:56 +0200]:
> Coding style issues here: trailing white space, and last line is aligned
> differently than the previous ones. Please make it consistent. Also,

I pulled this patch into my private git repo yesterday and fixed the
whitespace at the same time.  (I was without internet access though.)

> there was some fuzz applying this part. I suspect that the patch was
> generated against a 2.6.21 kernel tree. You should generate your
> patches against 2.6.22-rc5 or later to make sure they apply cleanly
> when Mark picks them.

I'm not sure that's a problem.  I pulled it into git on a branch from 2.6.21
and then merged it up to my testing branch - it did the right thing with no
trouble at all.  Now I need to answer the question of how a rebase will work in
the presence of merges.  If that goes well, then I really don't care what
version is used as a base.

(/me plays with git a bit more...)

Indeed, that went well.  So in general, people don't have to worry too much
about the base version for their patches.

Of course, if a particular patch results in a ton of merge conflicts I may ask
for a respin rather than resolve them all myself.  But this merge was conflict
free and I suspect most would be.

So, patch applied to testing (it will show up in my public repo later today).

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

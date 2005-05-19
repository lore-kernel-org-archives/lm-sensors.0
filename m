From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <20030428231533.GA16599@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

AFK last weekend, sorry...

* Greg KH <greg@kroah.com> [2003-04-28 09:58:26 -0700]:
> On Fri, Apr 25, 2003 at 08:34:33PM -0400, Mark D. Studebaker  wrote:

> > Namely, do we do another 2.4-compatible release.
> > I'm in favor of at least one more, because I would like to clear up some 
> > problems in 2.7.0.

Seconded.

> > The problems are really on the i2c side though.
> > 
> > I just studied up on CVS merging. It appears that you can only merge from 
> > the branch to the trunk?
> > In i2c, 2.4 is the branch and 2.5 is the trunk. I want to get some changes 
> > from
> > the trunk (for example new ID's in i2c-id.h) over to the 2.4 branch before 
> > we
> > do a release from the 2.4 branch.

Why not this?  http://www.loria.fr/~molli/cvs/doc/cvs_5.html#SEC57

> Why even worry about a 2.5 and onward version of the CVS tree?  Why not
> just use CVS for 2.4 and older, and use the in-kernel tree version of
> the sensors and i2c code for that stuff?

Won't we still need to branch lmsensors for userspace?

> If not, it's a lot of work to try to keep up with all of the other
> changes to the code, and placing it backwards into the cvs tree.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

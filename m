From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Setting vrm with 'sensors -s' is broken (w/ Linux 2.6.x)
Message-Id: <20040411040601.GB17920@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040407035157.GD6289@earth.solarsys.private>
In-Reply-To: <20040407035157.GD6289@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-04-07 21:56:33 +0200]:
> > Replacing
> >   *sysmag = (feature->scaling=0?0:3);
> > with
> >   *sysmag = feature->scaling;
> > as it used to be before I broke it should fix the problem.
> 
> Just did that.

BTW thanks.  I figured that would be the fix but I wasn't sure.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

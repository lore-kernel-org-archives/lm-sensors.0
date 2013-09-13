From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Sep 2013 05:51:25 +0000
Subject: Re: [lm-sensors] Backporting updated lm85 on RHEL5
Message-Id: <20130913075125.564b01bc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5229DE5D.7060104@elrepo.org>
In-Reply-To: <5229DE5D.7060104@elrepo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Sep 2013 22:35:31 +0100, Phil Perry wrote:
> On 12/09/13 20:14, Jean Delvare wrote:
> > I don't. That being said, this is a legacy branch, so we are only
> > accepting bug fixes and trivial additions. Any change requiring a
> > significant amount of new code would not be accepted, at least not by
> > me. If you really want it in and plan to contribute more to the legacy
> > branch then I'd rather create a subversion account for you and let you
> > become the maintainer of the legacy branch.
> >
> > Frankly, if your users have to install a non-standard lm_sensors
> > package, you might as well package version 3 and have all the support
> > for new chips for free.
> 
> That would indeed be preferable.
> 
> I can build lm_sensors-3 packages for RHEL-5 but the main issue I see is 
> that other packages in RHEL-5 (e.g, kdebase, net-snmp) require 
> libsensors.so.3 whereas lm_sensors-3 provides libsensors.so.4. Is 
> libsensors.so.4 backward compatible or is this a likely show-stopper?

Show-stopper I'm afraid. There's no form of compatibility between the
two.

> Maybe rebuilding these packages against an updated lm_sensors-3 package 
> would solve that issue. But still, this is really more than we'd ideally 
> like to do (we don't want to be replacing more packages in the distro 
> than we absolutely have to).

You're right, I had not considered other monitoring applications when
suggesting this move. My bad.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

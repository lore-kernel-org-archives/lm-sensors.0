From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <20030327222339.GB23888@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <20030327194248.GK32667@kroah.com> <3E835FEE.3050809@portrix.net> <20030327215344.GB1687@kroah.com>
In-Reply-To: <20030327215344.GB1687@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

* Greg KH <greg@kroah.com> [2003-03-27 13:53:44 -0800]:
> On Thu, Mar 27, 2003 at 09:32:46PM +0100, Jan Dittmer wrote:
> > Greg KH wrote:
> > 
> > >fan_min[1-3]	Fan minimum value
> > >in_min[0-8]	Voltage min value.
> > >pwn[1-3]	Pulse width modulation fan control.
> > >temp_input[1-3] Temperature input value.
> > Why not start all these counts from 0? Is there any reason to start from 
> > 1? Historical reasons or does the datasheet start the counting from 1?
> 
> Hm, good point.  It looks like most of the values started at 1, with the
> one exception being the voltage files "in".
> 
> I don't know why it's this way, history?  Perhaps someone from the
> sensors project can tell us.

Hardware designers tend to count devices starting with "1".  Silly them. :)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

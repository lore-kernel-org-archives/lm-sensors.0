From: andrew.grover@intel.com (Grover, Andrew)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <F760B14C9561B941B89469F59BA3A84725A248@orsmsx401.jf.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030326225234.GA27436@kroah.com>
In-Reply-To: <20030326225234.GA27436@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dominik Brodowski <linux@brodo.de>, Dave Jones <davej@codemonkey.org.uk>, Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>, Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com

> From: Dominik Brodowski [mailto:linux@brodo.de] 
> > Had occured to me too. There was talk of a libpower or the likes 
> > mentioned on acpi-devel a year or so back, but afaik nothing really 
> > came of it.
> 
> Actually, the "ospmd" tool (available at 
> http://acpi.sourceforge.net ) already seems to > manage APM and 
> ACPI input. Well, and speaking of ACPI and 
> sysfs in the same message: IMHO the /proc/acpi/ interface 
> should be replaced by something in /sysfs/ as well....

Agree w.r.t. ACPI /proc switching to sysfs. Just a matter of someone
sitting down and making the changes.

It is still not clear to me if libpower should subsume libsensors, or
vice versa, or keep them separate. There are areas of overlap, as well
as significant areas of non-overlap.

Regards -- Andy

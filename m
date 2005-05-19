From: mochel@osdl.org (Patrick Mochel)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: lm sensors sysfs file structure
Message-Id: <Pine.LNX.4.44.0304141014370.9285-100000@cherise>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A248@orsmsx401.jf.intel.com>
References: <20030326225234.GA27436@kroah.com>
In-Reply-To: <20030326225234.GA27436@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Dominik Brodowski <linux@brodo.de>, Dave Jones <davej@codemonkey.org.uk>, Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>, Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com


> It is still not clear to me if libpower should subsume libsensors, or
> vice versa, or keep them separate. There are areas of overlap, as well
> as significant areas of non-overlap.

IMHO, neither should subsume the other; there should be a 'libdevice', or
similar that has both a sensor and a power component to it.


	-pat

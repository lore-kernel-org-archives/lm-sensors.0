From: mochel@osdl.org (Patrick Mochel)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <Pine.LNX.4.33.0303271214380.1001-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030327185222.GI32667@kroah.com>
References: <20030326225234.GA27436@kroah.com>
In-Reply-To: <20030326225234.GA27436@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com


> > Btw, is it indended behaviour of sysfs, that after writing to a file, 
> > the size is zero?
> 
> Hm, don't know about that, I haven't seen that before.  If you cat the
> file after writing it, does the file size change?

It's a known problem that I haven't been able to track down. 

The file size is hardwired to PAGE_SIZE when it is created. For some 
reason, it's reset to 0 after it's opened. I haven't had a chance to track 
down why, or how to reset it..


	-pat

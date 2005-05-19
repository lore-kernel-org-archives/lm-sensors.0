From: ddj@cascv.brown.edu (Dave Johnson)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: lm_sensors2 Makefile
Message-Id: <20020930094811.B6280@mookie.cis.brown.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1033131073.3d945441d6d95@imp.free.fr>
In-Reply-To: <1033131073.3d945441d6d95@imp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At this point, I'm not fond of either approach... they each work better
in some situations than in others.  If someone familiar with autoconf
and the like would be able to "autoconfiscate" the lm_sensors build, the
choice of which kernel to reference could be parametrized.  I'm thinking
somewhere along the lines of "--use-running-kernel" and/or "--with-linux=...",
where the default would be /usr/src/linux[-2.4], running-kernel would be
/lib/modules/$(shell uname -r)/build, and --with-linux= would be specific
where the kernel sources are.  It's already possible to handle the default
and --with-linux just by putting "LINUX=/blah/de/blah" on the make command
line, but the running-kernel (or running-linux for consistency) would be
a useful shorthand.

A good generic rpm lm_sensors2.spec file would also be nice.  We're using
the NPACI Rocks cluster software collection, and for kernel-dependent 
modules, the source rpm files found in specific SRPMS directories are
automatically rebuilt when a cluster slave node is reinstalled.  I'd
like to be able to do this with lm_sensors as well.  Autoconf would be
nice but not necessary in this case, since environment variables can be
set up in the .spec file to override the defaults in the Makefile.

Right now, my highest priority is getting cluster nodes up and running.
But if I get to it before anyone else, I might take a stab at the .spec file.
We have two clusters that are being converted to Rocks, and three new clusters
ready or nearly ready to have the Rocks software installed from scratch.

	-- ddj

On Fri, Sep 27, 2002 at 02:51:13PM +0200, Khali wrote:
> 
> > Modified Files:
> > 	Makefile 
> > Log Message:
> > (mds) take LINUX from /lib/modules/x.x.x/build; patch from
> >       Dave Johnson <ddj@cascv.brown.edu>
> 
> Hmmm...
> This isn't that clear to me.
> 
> While the new way (/lib/modules/$(shell uname -r)/build) ensures we are 
> compiling the modules for the current kernel, the old way (/usr/src/linux) 
> allowed one to compile the modules for the default kernel, whatever the current 
> kernel is.
> 
> As far as I'm concerned, I prefer the old way. I happen to change kernel 
> versions quite often (testing both ACPI and CPUFreq on my system) and have to 
> reconfigure and reinstall i2c and lm_sensors everytime. Using /usr/src/linux as 
> the default, I am able to do so *before* I actually reboot on the new kernel. 
> With the new way, I would have to do the same *after* the reboot.
> 
> I would be pleased to listen to arguments in favor of the new way.
> 
> Anyway, whatever we decide, I think that we should do the same in i2c and 
> lm_sensors (which isn't the case right now).
> 
> Later,
> Khali

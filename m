From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-1.8.4 and lm_sensors-2.8.5 -- a comment
Message-Id: <20040420130823.GC16053@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 20, 2004 at 02:48:29PM +0200, Jean Delvare wrote:
> > Instead of running "/sbin/depmod -a -b $(DESTDIR)" and producing a
> > bunch of useless modules.* files, I would like to suggest that you
> > omit this and instead print a warning that depmod must be run after
> > the modules have been installed in their final location
> 
> I would much like to hear distribution packagers on this. Aurelien,
> Axel?
> 
> > (as far as Iknow most/all Linux distributions run depmod early in
> > their boot sequence) as follows:
> 
> True, but sometimes you want the modules to be usable directly. And some
> distributions run depmod too late in the boot process and some modules
> may be needed before that. I agree it's a distribution issue however.

Packaging involves installation under some DESTDIR of course and most
often into an empty one as well (e.g. there is no surrounding kernel).

Therefore running depmod at build/installtime (packaging time) is not
helpful for packaging. The depmod calls must be done at package
installation/deinstallation time.

And boot time is far late (but redundancy is good): Users don't want
to play "install-and-reboot" for simply upgrading some external kernel
modules, that "feature" is reserved for another "OS" ;).

For rpm's syntax this means:

$ rpm -q --scripts lm_sensors-kmdl-2.4.22-1.2179.nptl_47.rhfc1.at 
postinstall scriptlet (using /bin/sh):
/usr/lib/atrpms/addcustomkmdl '/lib/modules/`uname -r`/updates'
depmod -ae -F /boot/System.map-2.4.22-1.2179.nptl_47.rhfc1.at 2.4.22-1.2179.nptl_47.rhfc1.at
postuninstall scriptlet (using /bin/sh):
depmod -ae -F /boot/System.map-2.4.22-1.2179.nptl_47.rhfc1.at 2.4.22-1.2179.nptl_47.rhfc1.at

E.g. after installation/removal run depmod with forced kernel
version/symbols (as you may be installing/removing for a different
than the running kernel!).

But I wouldn't change current behaviour, as packagers know how to work
around this and users will certainly forget to issue a depmod if it
isn't done automatically.

== For completeness sake:

The /usr/lib/atrpms/addcustomkmdl is a special case for ATrpms kernel
modules which are installed under /lib/modules/`uname -r`/updates to
not conflict with /lib/modules/`uname -r`/kernel. The addcustomkmdl
scripts adds the following to the top of /etc/modules.conf so the
"updates" override the base versions:

path[toplevel]=/lib/modules/`uname -r`/updates
# default path
path[toplevel]=/lib/modules/`uname -r`

(technically some distributions don't need the above, they already
have modutils that look first under "updates", e.g. Fedora Core 1.)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040420/fe87e80c/attachment.bin

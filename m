From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Upcoming rpms: i2c headers under /usr/include/i2c
Message-Id: <20050103212012.GA29061@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041230173527.GF10397@neu.nirvana>
In-Reply-To: <20041230173527.GF10397@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 03, 2005 at 01:40:07PM +0100, Jean Delvare wrote:
> > > I have no idea where the correct location would be, so anything you
> > > come with is fine with me.
> > 
> > Perhaps indeed /usr/include/i2c/linux/i2c?
> > 
> > And I2C_HEADERS need to point (and default) to /usr/include/i2c, while
> > 
> > #include <linux/i2c/....>
> > 
> > picks the header either from a proper Linux kernel tree or from
> > I2C_HEADERS.
> 
> Since the includes actually are <linux/...>, not <linux/i2c/...>, that
> would be /use/include/i2c/linux. It is obviously important to have the
> same include "tree" (even if it has just a depth of 1) in /usr/include
> (or wherever it'll end) than we have in the Linux kernel source tree.

Yes, I mistyped the above. Actually for the rpms I did

mkdir -p %{buildroot}%{_includedir}/i2c/linux
cp -a kernel/*.h %{buildroot}%{_includedir}/i2c/linux

where buildroot is the "DESTDIR" for rpm builds and _includedir is the
macro pointing to /usr/include.

So I'm using /usr(/local)/include/i2c/linux for the headers and the
extra i2c slipped only in the mail above :)

BTW I didn't make any special announcements here, but the i2c and
lm_sensors rpm for RH7.3 til FC3 are uploaded at ATrpms. :=)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050103/ede87b4b/attachment.bin

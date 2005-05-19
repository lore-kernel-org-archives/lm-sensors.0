From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: Bugzilla
Message-Id: <20050515201515.GK4435@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <3Xg1uAGB.1110214165.5308430.khali@localhost>
In-Reply-To: <3Xg1uAGB.1110214165.5308430.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 15, 2005 at 10:03:47PM +0200, Jean Delvare wrote:
> Hi Axel,
> 
> > > Sounds better, but what about the drivers? Can there be
> > > subcomponents?
> > 
> > No there are only two levels. If you have a singleton product, you are
> > left with one only.
> > 
> > > The Linux kernel bugzilla has categories and components.
> > 
> > That's the same as products and components. They only replaced
> > "products" in the html pages with "categories" in thir customized
> > bugzilla, but if you query for a "category" you will see
> > http://bugzilla.kernel.org/buglist.cgi?...&product=...
> 
> OK I see. Must be the reason why they do not use a list for version but
> rather a free input. Maybe we should just do the same?

They have dropped the classical version field and patched up bugzilla
to have a new free field "kernel_version". kernel.org picked bugzilla
2.16 and modified it according to their needs. They are now quite
stuck to 2.16 series unless a bugzilla magician helps them migrate.

As long as bugzilla does not offer a nice way to customize it w/o
becoming a maintenance nightmare I'd recommend to not have too many
changes.

The reason for kernel.org to have a free version field is different
than for lm_sensors: kernel.org has a miriad of parallel trees with
complex versioning like 2.6.12-rc1-bk2 or -mm3 etc. lm_sensors has a
normal and simple versioning scheme, e.g. one that doesn't change as
frequently and thus doesn't need too much administrative maintenance.

Discrete versions have also the advantage that you can limit new bug
reports to supported versions.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050515/c852d2a5/attachment.bin

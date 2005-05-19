From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: /usr vs /usr/local
Message-Id: <20030909082014.GH2365@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030815221829.0f870e63.khali@linux-fr.org>
In-Reply-To: <20030815221829.0f870e63.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sun, Aug 24, 2003 at 05:12:00PM +0200, Jean Delvare wrote:
> > On Sat, Aug 23, 2003 at 07:24:02PM +0200, Jean Delvare wrote:
> > > Another thing I'm thinking of, back to the initial problem, is that
> > > we could make the script detect where sensors is (we already do for
> > > device files, modules.conf and dmidecode) so that the script works
> > > whatever the configuration.

> > This sounds a bit like an autoconf task. It would mean converting the
> > lm_sensors checks into m4 chuncks, which probably isn't worth while
> > for only defining the installation prefix.

> It's a bit more complex than that. Some parts (e.g. dmidecode) may be
> brought by external sources, so checking all possible locations sounds
> good. On the other hand, looking for files only in "our" prefix could
> prevent multiple versions conflicts (although conflicts can happen with
> modules, and there is no prefix for them).
> 
> We won't migrate to m4, that's sure.

Maybe simply provide a fake configure with a couple of options? It
could be made autoconfish like, e.g. have *.in files with @SOMETHING@
placeholders that the configure script simply seds (in the end effect,
that's what autoconf also does).

> All I want is to make packager's life easier, so that they don't need to
> maintain loads of patches for lm_sensors.

On another note: It would be good to have some stable detection
mechanism for i2c >= 2.8.0 in the kernel sources. Currently I am
simply comparing the version string to 2.8.0, but this will break the
moment the kernel will get to something greater. Do you have any nice
shell construct for detecting that? Maybe reverse checking instead for
2.6.5 and 2.7.0?
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030909/de8de00e/attachment.bin

From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: W83627HF SuperIO support in lm_sensors
Message-Id: <20030930090811.GH1714@pua.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929180436.GB1779@pua.nirvana>
In-Reply-To: <20030929180436.GB1779@pua.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Mon, Sep 29, 2003 at 09:42:48PM +0200, Jean Delvare wrote:
> > On Mon, Sep 29, 2003 at 05:49:47PM +0200, Alfredo Milani-Comparetti
> > wrote:
> > > The main problem is that the W83627HF module is not included
> > > amongst the loadable modules that can be MODPROBEd with your
> > > latest kernel for RH9. [...]
> > I used the kernel-patching method described in the lm_sensors 2.8.0
> > documentation. [...]

> Known "problem" (much more of a feature actually). Our patching script
> does only include the more stable drivers. Other drivers are only
> available when you compile modules outside of the kernel tree. Our
> sensors-detect script doesn't know about that of course, and detects
> whatever it can.

OK, I was not aware of that.

> If you want more drivers, either tweak the FILES and Config.in files in
> mkpatch, or build the modules directly in the lm_sensors directory
> instead of patching the kernel.

What do you think is better for an rpm (and what is better supported
by you in general)? I checked the first way and it would require
someone providing me with the changes, and these would have to be
synced with the next lm_sensors release.

The second proposal is something I could do propably without
assistance (building kernel modules), but this would have to wait for
some time (a couple of weeks), as it means ripping lm_sensors out of
the atrpms kernels and providing it seperately, and also rebuilding
and redistributing all further atrpms kernel modules.

On Tue, Sep 30, 2003 at 10:40:20AM +0200, Alfredo Milani-Comparetti wrote:
> I see :-)
> Anyway: since yours is a kernel recompiled for those who "know what they're 
> doing" and since setting up lm_sensors needs some knowledge, I think it would 
> be nice to include all those modules in your distribution.
> Consider that sensors-detect script already knows which modules are dangerous 
> and which ones are not and acts accordingly.
> Just a suggestion. Thank you for your time :-)

OK, sounds reasonable, what do you think, Jean?
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030930/9815bb5b/attachment.bin

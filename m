From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors/i2c 2.8.2
Message-Id: <20040104134604.GG5305@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104141910.64b647a2.khali@linux-fr.org>
In-Reply-To: <20040104141910.64b647a2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Jan 04, 2004 at 02:19:10PM +0100, Jean Delvare wrote:
> > I just saw that there is 2.8.2 available for some weeks now.  (BTW
> > could you put me on the developer's mailing list, so I catch that up
> > sooner? :)
> 
> Request sent, as you will have noticed.

Thanks!

> > I'd like to freshen the kernels, kernel modules and user land tools
> > for the Red Hat Linux (and FC) series. I see 2.8.2 i2c patches for
> > 2.4.22 and 23, but RH 9/8.0/7.3 are based on 2.4.20 plus some parts of
> > 2.4.21. Is it much trouble to backport it to the Red Hat Linux 2.4.20
> > sources?
> 
> Shouldn't be too much trouble. Drivers tend to be added, not removed, so
> all you'll have to do is not apply patches for drivers that did not
> exist in 2.4.20 yet (which is what I did myself when building the 2.8.0
> patch for kernel 2.4.21, so you can just pick the list here). Also,
> I guess that the i2c core patch won't apply cleanly, but you can always
> regenerate it using the mkpatch.pl script. So it seems to be feasable.
> 
> And in fact I could even update my 2.4.21 patch from 2.8.0 to 2.8.2. I
> though nobody would be interested in it, but obviously you, at least,
> are. I want to have a new patch for 2.4.24-preX anyway, so I'll some
> work on the web page and files soon.

OK, I'll wait for the 2.4.21 patch, that should apply better to RH's
2.4.20. FC1 is not the preferred distro for serious and stable server
monitoring that lm_sensors targets, so most people would like to see
it in RH9/RH7.3 (which is 2.4.20 with some 21-pre patches applied).

> That said, please note that there is not much change between 2.8.1 and
> 2.8.2 and that lm_sensors 2.8.2 will work with i2c 2.8.1. So if you
> already have a kernel with 2.8.1 working, you could consider skipping
> i2c 2.8.2 completely.

The RHL series I have patched are 2.8.0 currently, I'd gladly upgrade
them.

I managed to get 2.8.2 (both i2c and lm_sensors) built in my newest
FC1 kernel. I also build all lm_sensors modules on top of that to get
a package with the more experimental modules, not included in the
kernel patch. I am still in testing phase, though.

Also if 2.8.3/2.9.0 keep i2c 2.8.2 compatibility, I will be able to
supply new kernel module rpms for lm_sensors/i2c w/o rebuilding the
kernel. :)
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040104/31625662/attachment.bin

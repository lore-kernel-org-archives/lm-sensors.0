From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Request to fix mkpatch
Message-Id: <Pine.OSF.4.50.0301211031150.28783-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301171937460.6850-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301171937460.6850-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Jan 2003, Mark Studebaker wrote:

> Is i2c mkpatch working for 2.4 kernels now?
> We need that to work and not break from 2.5 fixes.

Most of mkpatch is <2.4 makefile stuff and i2c conversion.
I have removed some of these for the 2.5, and limited patching
outside the build system files to get something done.

For 2.4 I have not verified if patching build/config files
actually produces nice result.

> Can we still compile i2c outside of the kernel or do we
> need to patch the kernel?

Yes for 2.4. For 2.5 some includes to asm/ are arch dependent
and fail (pcf-epp, elektor, rpx, 8xx).

> Obviously you can't mix old and new modules because of
> refcount changes. But if you remove all your old i2c
> modules and then load new ones it should work, right?

It should, yes. Problems are only expected if one compiles
video4linux modules from unpatched tree without modversions
and then compiles i2c out of kernel and mixes those.

So support of next i2c release would be 2.4.9+ if no video4linux i2c
drivers are needed, 2.4.20+patching otherwise. V4L in 2.4.20 needs
patches anyway.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

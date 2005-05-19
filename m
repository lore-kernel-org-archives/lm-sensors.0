From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Request to fix mkpatch
Message-Id: <3E2C9BA0.3050103@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301171937460.6850-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301171937460.6850-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Is i2c mkpatch working for 2.4 kernels now?
We need that to work and not break from 2.5 fixes.

Can we still compile i2c outside of the kernel or do we
need to patch the kernel?
Obviously you can't mix old and new modules because of
refcount changes. But if you remove all your old i2c
modules and then load new ones it should work, right?

Trying to figure out the easiest way to get myself going again...


Ky?sti M?lkki wrote:
> I have little clue of mkpatch. I hope someone could trace back
> Configure changes from 2.5 tree and have it make clean diffs.
> 
> Applies to both i2c and sensors.
> 

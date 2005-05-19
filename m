From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <3EAD8F39.654DBE9E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 64-bit, I have an Intel 64-bit system, haven't recompiled in a while, but
it works, last time I was really working on it I don't think I fixed 
all the compiler warnings. I can look at it again if it's timely.

On the lm85 patch, I can check it into CVS if it isn't in there already
(can't remember where we left it - will have to check)

On a release, let's call it 2.8.0 (since we removed all pre-kernel-2.4.9 compatibility)
and let's release in 2-3 weeks. We'll release from the lm_sensors tree
and from the lk2-4 branch of the i2c tree.
I think any "reverse merges" from the trunk to the lk2-4 branch in
i2c will have to be manual. But it shouldn't be very much.
Mainly the new ID's in i2c-id.h.

sound like a plan?

mds



Greg KH wrote:
> 
> On Sat, Apr 26, 2003 at 10:47:06PM -0700, Philip Pokorny wrote:
> > I'd personally like to see my lm85 patch make it into 2.7.x...
> 
> Have a reference to it?  If it works with 2.5 right now, I'd be glad to
> add it.
> 
> > Also, I've recently compiled i2c on a 64-bit Opteron and there are several
> > type conversion issues that are not 64-bit clean.  I looked into it a
> > little bit and the conversions seemed wrong even in a 32-bit environment
> > (ints to void *)
> 
> Hm, not good.  I'll gladly take patches to fix this problem.  I think I
> even have access to a amd64 box around here somewhere that I could test
> them out on.
> 
> > If you haven't already encountered these problems, then I'll work up a
> > patch and post it.
> 
> Patches are always welcome :)
> 
> thanks,
> 
> greg k-h

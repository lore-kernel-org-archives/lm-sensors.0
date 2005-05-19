From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: About to release (Was: EMC6D100 patch)
Message-Id: <3F08D180.9030902@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030705194327.06a971c1.khali@linux-fr.org>
In-Reply-To: <20030705194327.06a971c1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Agreed, I think the last thing is fixing the perl problem in sensors-detect.

Let's not check in anything else except for that fix and
documentation updates.

I did take one pass through the docs but everybody else please look at
and fix/improve more as you see fit.



Jean Delvare wrote:
>>patch doesn't compile, no SYSCTL_IN5-7 definitions,
>>please retest before you send us something, we're about to release...
> 
> 
> As we speak about this, what is left to be done before we can release?
> Refreshing our checklist could be great:
> 
> - sensors-detect "UTF" issue
> Almost fixed, an incompatibility with perl 5.5 remains but should be
> solved soon.
> 
> - libsensors numbering because of binary incompatibility..... go to
> 1.5.0 or 2.0.0?
> Done.
> 
> - Delete sensors.h in sensors/include, move files?
> I think I remember it's done?
> 
> - Incompatibility w/ 2.4 kernel i2c structs
> Left to me it seems ;) Does it really need to be done *before* the
> release? It will anyway take time before the patch is accepted and
> kernel 2.4.22 is released (although the .22 cycle should be faster than
> .21).
> 
> - Need testing against kernel 2.4.9
> MMH tested and it works, right? Mark, or did you only checked that
> mkpatch was working, without actually testing?
> 
> - Mkpatch - abandon, fix, what?
> MDS fixed them, right?
> 
> - Update README, INSTALL, etc.
> Done by MDS too IIRC.
> 
> - Fix GCC 3 compilation warnings.
> Fixed, and all other warnings too.
> 
> I'll retest everything on my four or five systems right before we
> release anyway.
> 
> Comments welcome.
> 

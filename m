From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <20031228152909.50a37848.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Forget about -km-2 and -km-6. I will post them in smaller parts.

Never received -km-6, so I can forget about it very easily ;) What about
-km-4?

As for -km-2, don't forget that there is no real use splitting patches
if parts cannot be applied independantly. And I repeat myself, please
first fix module reference counting in CVS before posting any patch
related to this point. Again, we cannot send anything to Marcelo with
regression in it.

> Patch -km-7 : Drop 2.2 code.
> Patch -km-8 : User progs don't include kernel files.
> Patch -km-9 : Message block size.
> Patch -km-10 : Remove SLO_IO in algo-bit.
> Patch -km-11 : Bus scan removal, bit & pcf.
> Patch -km-12 : Add new IDs.
> Patch -km-13 : Unused code, whitespace.

Great. I already have patches for 10 and 11 (more complete since it also
handles drivers that are not in our CVS repository). I will take a look
at your patches in a while, as time permits.

> Yes, christmas got cancelled ;)

;) You know, we merely depend on Marcelo for having our patches applied.
I don't plan to submit anything new until he approved (or disapproved)
the previous wave of patches. This of course doesn't prevent us from
working on new patches, but there's no need skipping Christmas if you
don't want to. Unless you, like I, don't enjoy these days too much and
were after some kind of excuse for missing them ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

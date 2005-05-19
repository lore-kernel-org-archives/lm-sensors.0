From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040410181732.2498ddc7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> No, I used the patches posted here. Does CVS have more changes applied
> than these?

I actually sent two sets of patches. The initial mkpatch patch being
broken, I sent a second a few hours after. Maybe you simply missed that
one and are using the wrong one (it would actually produce the error you
are encountering).

> At any rate I'll reiterate a build straight from the CVS, and check
> whether dmi_scan.c sneaks in again. ;)

Yes please. The CVS stuff is supposed to do the same as the patches I
sent, but in a different way: mkpatch now handles the additional kernel
change to dmi_scan by itself, with no external patch needed. This is
worth testing to ensure it works properly, especially since you do have
many more patches applied to you tree, which could cause trouble.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

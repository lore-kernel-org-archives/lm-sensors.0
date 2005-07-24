From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Jul 2005 17:51:42 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <20050724175133.66bab1b3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E04664.3020001@divsol.com>
In-Reply-To: <42E04664.3020001@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > So, patch attached, which adds a # comment, so that when clueful
> > users look at the line in the makefile, they'll know why its an
> > error. Also replaced leading spaces with tabs, to keep emacs
> > makefile mode from interrogating me on saves (not needed for making,
> > but saves  annoyance).
>
> ahh, umm, here it is.  I hate it when I do that. which is too often.

OK, applied, thanks.

For next time, please remember that sending separate patches for
separate things is generally better, as one part may be OK and the other
one may not be or may need discussion.

Thanks,
-- 
Jean Delvare

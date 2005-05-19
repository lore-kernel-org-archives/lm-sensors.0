From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: mkpatch and diff
Message-Id: <20031115200543.0b1b0d95.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031115112127.257c5407.khali@linux-fr.org>
In-Reply-To: <20031115112127.257c5407.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Replying to myself...)

> In the mkpatch.pl scripts, we use "diff -u2" to generate the diffs.
> Since this option is deprecated and it should be "diff -U 2", I was
> about to update this line, and wondered why this option was in use.
> 
> I tested without this option and the patch is actually *smaller* than
> when using only two lines of context (242846 bytes with the option,
> 210144 without it).

I have to correct what I said here. The size I give here is with no option at all, but this produces a non-unified diff, so this is rather useless. A unified diff with 3 lines of context is bigger (257616 bytes), as expected.

> The only reason I can see is that it might help
> using the patch on a different version of the Linux kernel than the
> one that was used as a base.

I have to correct this too. If more context exists, patch is still able to ignore the lines that would cause the operation to fail. So, size left apart, there is no benefit specifying a smaller "u" value for diff.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

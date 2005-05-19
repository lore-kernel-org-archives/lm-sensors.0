From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: To release or not to release
Message-Id: <1074076436.40051b1473646@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109231508.349f206a.khali@linux-fr.org>
In-Reply-To: <20040109231508.349f206a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I know we haven't done it in the past, but why not do a RC release,
> freeze for a week or so, then put on the final tag?

This would be more work for Phil with no apparent benefit. Our project
is admitedly popular, but I don't think we would have enough feedback
between RC and final releases to justify the existence of a RC.

What's more, I think we'll need to follow a 1:1 release policy with
Linux 2.6 for some times (at least we need a release to support 2.6.1
correctly, and another one will be needed for 2.6.2 if it has the temp
magnitudes fixes; my guess is that similar situations will occur a few
more times after that).

So I think that we need to release more often than we used to do, and
more particularly be more reactive when releases are needed to follow
Linux 2.6 releases.

Special note to Phil:
Please release 2.8.3 as soon as possible.

If you are too busy to do so and/or more generaly prefer that we do not
depend on you to do releases, I can handle them for you, if this is
technically possible. I know that we have a document which summaries
the various checkpoints for releases, but I don't know if all of them
can be done with just a developer CVS access or if more than that (such
as a SSH access) is required.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

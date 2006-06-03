From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 03 Jun 2006 09:50:32 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060603115032.b0ef222d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger, Hans,

> > Say worst case scenario is 2000 files each taking 4kb that sums up to
> > 8Mb diskspace, sounds acceptable to me, what do others think?

I admit it's acceptable by today's standards, but given that it's 5
times the size of lm_sensors itself (user-space part), I'd expect
distributions to ship it as a separate, optional package. And we
probably should do as well.

> That doesn't sound that big, but it will continue to grow.  The files are
> text files, however, and there will be significant common text between them
> so I would expect that gzip'd TAR of them would dramatically reduce their
> size.  If any tool could work with a tgz archive rather than requiring the
> files directly then this could save a lot of space on the disk.

Storing the base as a tar.gz file would probably slow down its use
(maybe not that much) and will also make hacking harder (how do I add
or modify a file for test purposes?) I was about to suggest
compressing individual configuration files instead (as commonly done
with manual pages) but I just realized it wouldn't spare much space, if
at all, as in most cases configuration files tend to be smaller than
the node size of the file system anyway.

Anyway this is an implementation detail which can be addressed
afterwards if needed.

-- 
Jean Delvare


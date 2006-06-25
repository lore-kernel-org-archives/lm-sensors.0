From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 25 Jun 2006 16:00:30 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <449EB31E.4020105@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> I am happy with the code now, but there is a problem with the sysfs file
> names, see below.

Ok. I'm attaching fixed versions of both.

> And manual fan speed control too.

Ok I will mention, although I considered this a special case of automatic regulation


> We should at least have read-only files to let the user know the
> mapping.

The mapping is trivial and programmable for fan4 only.
I fixed the docs.

> I'm just realizing that these names are quite wrong. For example
> temp1_target may not be related to temp1 but to a different temperature
> sensor depending on the temp/fan mapping. The "1" here really means
> pwm1, not temp1. So these files should be named pwm[1-4]_target_temp
> and pwm[1-4]_tolerance_temp, respectively.

Yes correct. Fixed.


> BTW, these file names should also be added to sysfs-interface.

If we consider this as standard for some chips. We would need some mapping
standard too (Yuan did some file for w83793)

> But the driver uncondionally creates both files? This needs to be
> investigated, and fixed (either the driver or the documentation.)

I fixed the note. The files are used in SF3 iirc, so we might have them.

This patch adds long-awaited support for automatic fan modes. Based on the work
of Yuan Mu from Winbond, I finished the support with the great help of David
Hubbard. Many thanks goes to Jean Delvare, for his reviews and patience.
The documentation update will follow.

Signed-Off-By: Yuan Mu <Ymu at Winbond.com.tw>
Signed-Off-By: Rudolf Marek <r.marek at sh.cvut.cz>
Signed-Off-By: David Hubbard <david.c.hubbard at gmail.com>

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ehf_next_try8.patch
Type: text/x-patch
Size: 16860 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060625/878aa562/attachment.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ehf_docs1.patch
Type: text/x-patch
Size: 3706 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060625/878aa562/attachment-0001.bin 

From: tres@mindspring.com (Tres Melton)
Date: Sun, 26 Feb 2006 18:00:51 +0000
Subject: [lm-sensors] 64bit cleanliness issue
Message-Id: <1140976852.12219.48.camel@thor.tres.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gents,

I'm not on the mailing list so please CC me if needed.

64bit cleanup to lm_sensors-2.9.2
lib/proc.c:236: warning: passing arg 4 of `sysctl' from incompatible pointer type
lib/proc.c:427: warning: passing arg 4 of `sysctl' from incompatible pointer type
lib/proc.c:468: warning: passing arg 4 of `sysctl' from incompatible pointer type

This is detailed & patched in Gentoo Bug #124172
http://bugs.gentoo.org/show_bug.cgi?id4172

Cheers,
-- 
Tres Melton
IRC & Gentoo: RiverRat
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 191 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060226/1c254314/attachment.bin

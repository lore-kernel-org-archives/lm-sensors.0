From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] fix typo in isaset manpage
Message-Id: <20050501154647.GA2589@procyon.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

The isaset manpage still has "i2cset" in the NAME section; this patch
fixes it:

--- lm_sensors-2.9.1/prog/dump/isaset.8.alt-man	2004-10-16 18:24:55 +0400
+++ lm_sensors-2.9.1/prog/dump/isaset.8	2005-05-01 19:40:32 +0400
@@ -1,6 +1,6 @@
 .TH ISASET 8 "August 2004"
 .SH "NAME"
-i2cset \- set ISA registers
+isaset \- set ISA registers
 
 .SH SYNOPSIS
 .B isaset

-- 
Sergey Vlasov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050501/e816d53f/attachment.bin

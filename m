From: oe@hentges.net (Matthias Hentges)
Date: Wed, 18 Oct 2006 13:21:01 +0000
Subject: [lm-sensors] [PATCH 1/3] export the do_rdmsr/do_wrmsr function
Message-Id: <1161177661.4413.23.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
References: <453299F8.8020503@assembler.cz>
In-Reply-To: <453299F8.8020503@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

2.6.19-rc2-git2 together with your latest patch-set fixes the compile
problem I encountered with cpu hotplug enabled, thanks!

Am Dienstag, den 17.10.2006, 23:29 +0200 schrieb Rudolf Marek:
> Hello,
> 
> Here comes an updated patch. The functions are exported as msr_read and 
> msr_write. I think I fixed the compilation isssues.
> 
> Regards
> Rudolf
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
-- 
Matthias 'CoreDump' Hentges 

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061018/249ebe31/attachment.bin 

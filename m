From: oe@hentges.net (Matthias Hentges)
Date: Sun, 15 Oct 2006 23:46:27 +0000
Subject: [lm-sensors] [PATCH 0/3] coretemp driver
Message-Id: <1160955987.4413.9.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
References: <45329771.7030108@assembler.cz>
In-Reply-To: <45329771.7030108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

Am Sonntag, den 15.10.2006, 22:17 +0200 schrieb Rudolf Marek:
> Hello all,
> 
> Following series of patches adds support for the temperature sensors inside the
> Intel Core family processors.
> 
> It would be nice if someone could test the stuff again and read the
> documentation and code to see if all is OK

I've just applied this patchset to 2.6.19-rc2. If I enable "Processor
type and features / Support for hot-pluggable CPUs (EXPERIMENTAL)", the
coretemp driver no longer compiles (not as module and not compiled into
the kernel).

Thanks,
-- 
Matthias 'CoreDump' Hentges 

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
A non-text attachment was scrubbed...
Name: make_bzImage.tmp.gz
Type: application/x-gzip
Size: 2257 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061016/fe00d9a3/attachment.gz 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061016/fe00d9a3/attachment.bin 

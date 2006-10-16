From: oe@hentges.net (Matthias Hentges)
Date: Mon, 16 Oct 2006 22:07:15 +0000
Subject: [lm-sensors] [PATCH 0/3] coretemp driver
Message-Id: <1161036435.4413.15.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
References: <45329771.7030108@assembler.cz>
In-Reply-To: <45329771.7030108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

Am Montag, den 16.10.2006, 20:22 +0200 schrieb Rudolf Marek:
> Hello Mattias,
> 
> Thanks for the test.

thanks for your work on the driver ;)

[...]

> Please do not include the binary attachments, the mailing list will throw such 
> mails away...

Sorry for that, I'll try to keep it in mind.

>  >coretemp.c:(.init.text+0x6e0d): undefined reference to 
>  >`register_hotcpu_notifier'
>  >drivers/built-in.o: In function `coretemp_exit': 
> 
>  >coretemp.c:(.exit.text+0x82f): undefined reference to 
>  >`unregister_hotcpu_notifier'
>  >make: *** [.tmp_vmlinux1] Fehler 1
> 
> Hmm I tried with the rc2 and it does work. (it reports just a complain about 
> missing function prototype - I fixed that). Please can you send me your .config 
> file? Maybe you need to make clean; before doing the test?

I certainly made sure to run "make clean" after each run =)
You can find my kernel .configs here:
http://hentges.net/tmp/debug/asus-p5w-dh-deluxe/lm-sensors/coretemp/20061016/

Thanks,
-- 
Matthias 'CoreDump' Hentges 

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061017/f572111e/attachment.bin 

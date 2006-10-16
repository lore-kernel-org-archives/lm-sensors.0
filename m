From: r.marek@assembler.cz (Rudolf Marek)
Date: Mon, 16 Oct 2006 18:22:40 +0000
Subject: [lm-sensors] [PATCH 0/3] coretemp driver
Message-Id: <4533CDF0.10608@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45329771.7030108@assembler.cz>
In-Reply-To: <45329771.7030108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Mattias,

Thanks for the test.

> I've just applied this patchset to 2.6.19-rc2. If I enable "Processor
> type and features / Support for hot-pluggable CPUs (EXPERIMENTAL)", the
> coretemp driver no longer compiles (not as module and not compiled into
> the kernel).

Please do not include the binary attachments, the mailing list will throw such 
mails away...

 >coretemp.c:(.init.text+0x6e0d): undefined reference to 
 >`register_hotcpu_notifier'
 >drivers/built-in.o: In function `coretemp_exit': 

 >coretemp.c:(.exit.text+0x82f): undefined reference to 
 >`unregister_hotcpu_notifier'
 >make: *** [.tmp_vmlinux1] Fehler 1

Hmm I tried with the rc2 and it does work. (it reports just a complain about 
missing function prototype - I fixed that). Please can you send me your .config 
file? Maybe you need to make clean; before doing the test?

Thanks,
Rudolf


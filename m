From: christian.mahr.ulm@arcor.de (Christian Mahr)
Date: Sun, 12 Nov 2006 14:16:30 +0000
Subject: [lm-sensors] [PATCH 0/3] coretemp driver
Message-Id: <200611121516.30428.christian.mahr.ulm@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <45329771.7030108@assembler.cz>
In-Reply-To: <45329771.7030108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf pointed me to the most recent version of the patch . this does include the fix already.
Sorry to bother

	Christian

Am Sonntag, 12. November 2006 12:16 schrieb Christian Mahr:
> Hi Rudolf,
>
> concerning:
>  >coretemp.c:(.init.text+0x6e0d): undefined reference to
>  >`register_hotcpu_notifier'
>  >drivers/built-in.o: In function `coretemp_exit':
>  >
>  >coretemp.c:(.exit.text+0x82f): undefined reference to
>  >`unregister_hotcpu_notifier'
>  >make: *** [.tmp_vmlinux1] Fehler 1
>
> I found the problem: you have to include one more header file:
>
> 37d36
> < #include <linux/cpu.h>
>
> and it works!  --> please add the line to your sources.
>
> The bug is noticable only if you switch on HOTPLUG_CPU otherwise it does
> not appear.
>
> Best regards
> 	Christian
>
> PS many thanks for the driver, I do use it in 2.6.18.1
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061112/9e330b29/attachment.html 

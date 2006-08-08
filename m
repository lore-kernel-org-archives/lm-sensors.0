From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 08 Aug 2006 14:55:20 +0000
Subject: [lm-sensors] Vt1211
Message-Id: <191fb4ca0608080755k2d8d8c0bj8cedb9acc17f75c4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
In-Reply-To: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tomislav,

Yes, you need to patch the kernel to get the vt1211 module.

1) Download the vanilla 2.6.17.8 kernel from www.kernel.org
2) Get the most recent vt1211 patch from here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016329.html
3) Patch, recompile and install the new kernel and modules (make sure
to enable the vt1211 under 'device drivers/hardware monitoring
support')
4) Reboot using the new kernel and modprobe the vt1211 module

...juerg


On 8/8/06, Tomislav Par?ina <tparcina at lama.hr> wrote:
> Do I need to patch Kernel to make lm_sensors work on Fedora Core 4 (2.6.11) and Via EPIA (vt1211 chip) motherboard? If yes, what patch should I use and is there any complete instructions how to do it?
>
> I have tried to use patch (this one http://hem.bredband.net/ekmlar/patch-vt1211-2.6.11.txt ) found on this pages http://hem.bredband.net/ekmlar/vt1211.html
>
> And when I execute make bzImage I get following error
> scripts/mod/sumversion.c:486: warning: pointer targets in passing argument 1 of
> 'strlen' differ in signedness
> scripts/mod/sumversion.c: In function 'maybe_frob_rcs_version':
> scripts/mod/sumversion.c:496: warning: pointer targets in passing argument 1 of
> 'strip_rcs_crap' differ in signedness
>   HOSTLD  scripts/mod/modpost
> make[1]: *** No rule to make target `init/main.o', needed by `init/built-in.o'.
>  Stop.
> make: *** [init] Error 2
>
> I would preheated any help on what patch to use and how to patch kernel. Thank you!
>
>
> **
>
> P.S.
> Without patching the kernel I can't modprobe vt1211 driver
>
>
> --
> Tomislav Par?ina
> Lama Computers Split
> Stinice 12, 21000 Split
> Tel.: +385(21)495148
> Mob.: +385(91)1212148
> SIP: tomo at pbx.lama.hr
> e-mail: tparcina#lama.hr
> http://www.lama.hr
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

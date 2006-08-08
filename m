From: tparcina@lama.hr (=?iso-8859-2?Q?Tomislav_Par=E8ina?=)
Date: Tue, 08 Aug 2006 10:00:53 +0000
Subject: [lm-sensors] Vt1211
Message-Id: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Do I need to patch Kernel to make lm_sensors work on Fedora Core 4 (2.6.11) and Via EPIA (vt1211 chip) motherboard? If yes, what patch should I use and is there any complete instructions how to do it?

I have tried to use patch (this one http://hem.bredband.net/ekmlar/patch-vt1211-2.6.11.txt ) found on this pages http://hem.bredband.net/ekmlar/vt1211.html

And when I execute make bzImage I get following error
scripts/mod/sumversion.c:486: warning: pointer targets in passing argument 1 of
'strlen' differ in signedness
scripts/mod/sumversion.c: In function 'maybe_frob_rcs_version':
scripts/mod/sumversion.c:496: warning: pointer targets in passing argument 1 of
'strip_rcs_crap' differ in signedness
  HOSTLD  scripts/mod/modpost
make[1]: *** No rule to make target `init/main.o', needed by `init/built-in.o'.
 Stop.
make: *** [init] Error 2

I would preheated any help on what patch to use and how to patch kernel. Thank you!


**

P.S.
Without patching the kernel I can't modprobe vt1211 driver


--
Tomislav Par?ina
Lama Computers Split
Stinice 12, 21000 Split
Tel.: +385(21)495148
Mob.: +385(91)1212148
SIP: tomo at pbx.lama.hr
e-mail: tparcina#lama.hr
http://www.lama.hr


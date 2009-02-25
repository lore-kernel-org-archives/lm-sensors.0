From: Michael Reinelt <michael@reinelt.co.at>
Date: Wed, 25 Feb 2009 04:50:28 +0000
Subject: Re: [lm-sensors] module c7temp shows voltage, but no temperature
Message-Id: <49A4CE14.3000308@reinelt.co.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <200902221052.31780.justin@justinzane.com>
In-Reply-To: <200902221052.31780.justin@justinzane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Juerg Haefliger wrote:
> Please also run cpuid -r.

here you are:

artus.reinelt.local:~ # cpuid -r
CPU:
   0x00000000: eax=0x00000001 ebx=0x746e6543 ecx=0x736c7561 edx=0x48727561
   0x00000001: eax=0x000006d0 ebx=0x00000800 ecx=0x00004181 edx=0xa7c9bbff
   0x80000000: eax=0x80000006 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0x80000001: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00100000
   0x80000002: eax=0x20202020 ebx=0x20202020 ecx=0x20202020 edx=0x20202020
   0x80000003: eax=0x20202020 ebx=0x56202020 ecx=0x43204149 edx=0x72502037
   0x80000004: eax=0x7365636f ebx=0x20726f73 ecx=0x30303531 edx=0x007a484d
   0x80000005: eax=0x00000000 ebx=0x08800880 ecx=0x40040140 edx=0x40040140
   0x80000006: eax=0x00000000 ebx=0x00000000 ecx=0x0080a140 edx=0x00000000
   0x80860000: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0xc0000000: eax=0xc0000003 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0xc0000001: eax=0x00000000 ebx=0x00000002 ecx=0x00000000 edx=0x0000ffcc
   0xc0000002: eax=0x00000000 ebx=0x08000810 ecx=0x08100f13 edx=0x42040000
   0xc0000003: eax=0x57762abe ebx=0xce237d7f ecx=0x5ee56564 edx=0xe8619e36


I tried another thing, which unfortunately is not promising: I ran cpuid
-r several times, nothing changed. Then I started a cpuburn process
(which should lead to a cpu temp increase) but again: nothing changed in
the output of cpuid :-(


<crying> I want a CPU temperature! </crying>

-- 
Michael Reinelt <michael@reinelt.co.at>
http://home.pages.at/reinelt
GPG-Key 0xDF13BA50
ICQ #288386781

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

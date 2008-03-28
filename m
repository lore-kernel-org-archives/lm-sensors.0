From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 28 Mar 2008 22:18:16 +0000
Subject: Re: [lm-sensors] QX9650 Core Temperatures
Message-Id: <47ED6EA8.6000505@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <47EBD5C0.10100@stny.rr.com>
In-Reply-To: <47EBD5C0.10100@stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Please send here output of cat /proc/cpuinfo
or provide output from "cpuid" utility.

I think it is model 10h. So in fact you need following patch:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=AE770152c801f10a91e5e86597a39b5f9ccf2d0d

Or 2.6.25rcxx kernel

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: undetected chips
Message-Id: <BXGl1CHS.1091800082.0666240.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408050908.47507.ramon.casha@linux.org.mt>
In-Reply-To: <200408050908.47507.ramon.casha@linux.org.mt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>> Try forcing the adm1025 driver (modprobe amd1025 force_adm1025=0,0x2d)
>> and see how it goes.
>
>seems like my kernel (2.6.3) doesnt have that - the closest is adm1021 which
>doesn't do much.

You're correct, the adm1025 driver was ported to Linux 2.6 only very
recently (2.6.8-rc2). So you'll have to upgrade your kernel if you want
support for it (providing it really is what I think it is).

Alternatively, a 2.4 kernel with the lm_sensors drivers will do, if
you're used to it.

Jean Delvare

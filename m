From: juergh@gmail.com (Juerg Haefliger)
Date: Wed, 09 Aug 2006 14:50:08 +0000
Subject: [lm-sensors] Vt1211
Message-Id: <191fb4ca0608090750w242e893x451a49e907ae25dd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
In-Reply-To: <79337FA3BA80774F9FE87BF809C9F3564309A3@stipe.lama.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tomislav,

> Can you send me pre-compiled vt1211.ko driver? Can I put your pre-compiled driver to
> /lib/modules/2.6.11-1.1369_FC4/kernel/drivers/i2c/chips and execute
> "depmod -a"?
> Will that work?

No that won't work. The kernel version and the driver need to match
and I don't have a precompiled 2.6.11 version. 2.6.11 is too old a
kernel anyway.
You need at least 2.6.17 (I believe). There's no way around a kernel
compilation if you want to use the latest driver.


> Because I have tried to recompile kernel several times and I
> still haven't managed to install driver.

What do you mean?


> And kernel compilation on VIA EPIA motherboard lasts forever...

Yeah, VIA CPUs are not exactly blazingly fast.


...juerg


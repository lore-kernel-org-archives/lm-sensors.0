From: synaptical@linuxquestions.net (synaptical)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: can't compile i2c-2.8.3 on linux-2.6.2
Message-Id: <20040205225113.6BA67396B@sitemail.everyone.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040204194802.35A2CACA5@sitemail.everyone.net>
In-Reply-To: <20040204194802.35A2CACA5@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks, i don't think i'll ever get the hang of lm_sensors! they work now indeed, apparently increased by a factor of 10 -- but i think i remember seeing something about that in the doc, and it is not a big deal. 

the only other comment i would make is the readings used to appear next to the CPU and Proc headings in gkrellm, and now they take up their own space, which adds length to gkrellm. again not a big deal, but i thought i would mention it as it is a difference. 

appreciate your help and patience. 

--- Jean Delvare <khali@linux-fr.org> wrote:
> i compiled the kernel with make clean; lm_sensors compiled after a
> make clean in lm_sensors. but i2c won't compile, it keeps giving me a
> "no rule to make target" error:
> 
> make: *** No rule to make target `mach_mpspec.h', needed by
> `kernel/i2c-pport.d'.  Stop.

I2c and the lm_sensors kernel modules are already part of Linux 2.6.2.
You don't need to compile them apart (and it wouldn't work, as you
noticed).

All you need to do is compile and install the lm_sensors user-space
tools with "make user" and "make user_install" (in lm_sensors,
obviously). The rest is meant for 2.4 kernels, not 2.6 kernels.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/


_____________________________________________________________
Thank you for choosing LinuxQuestions.
http://www.linuxquestions.org

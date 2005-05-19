From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: can't compile i2c-2.8.3 on linux-2.6.2
Message-Id: <1076058726.40235a6674b56@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040204194802.35A2CACA5@sitemail.everyone.net>
In-Reply-To: <20040204194802.35A2CACA5@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting synaptical <synaptical@linuxquestions.net>:

> thanks, i don't think i'll ever get the hang of lm_sensors! they work
> now indeed, apparently increased by a factor of 10 -- but i think i
> remember seeing something about that in the doc, and it is not a big
> deal. 

You need lm_sensors CVS or 2.8.4 as soon as we release it. Version 2.8.3
doesn't work correctly with Linux 2.6.2.

> the only other comment i would make is the readings used to appear
> next to the CPU and Proc headings in gkrellm, and now they take up
> their own space, which adds length to gkrellm. again not a big deal,
> but i thought i would mention it as it is a difference.

I don't understand what you mean exactly, maybe because I never used
gkrellm myself. That said, it is more likely a problem with gkrellm
itself, so you should probably contact the developers of that program
instead.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Ported lm80 to Linux 2.6
Message-Id: <1076603062.402ba8b675d8c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076403383.40289cb779c27@imp.gcu.info>
In-Reply-To: <1076403383.40289cb779c27@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Tiago Sousa <mirage@kaotik.org>:

> darksun:~# i2cdetect 0 0x2d

Oh sorry I told you wrong. I really meant i2cdump, not i2cdetect. And
unloading lm80 before dumping is suggested.

> I'm not too concerned with the LM80 chip because via686a has the info
> I really need.

Sure, I understand.

> Also, as stated in the 2.6 kernel information on the lm_sensors site,
> the via686a and i2c-viapro don't work together, so I've been using
> only i2c-isa with via686a, and not i2c-viapro with lm80 too. Just
> pointed this out, in case it makes a difference to the detection
> process (probably not because LM80 is also detected in kernel 2.4).

Doesn't make any difference, but this reminds me that we should
investigate the problem.

I have commited an update to sensors-detect to our CVS repository. I'd
be interested in you trying it. It is supposed to refine the LM80
detection procedure. I hope that it won't detect whatever-your-chip-is
as an LM80 anymore.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

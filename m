From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Regarding the W83627HF..
Message-Id: <20031222222019.26526175.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031222214430.066b3e4d.clauz@punkass.com>
In-Reply-To: <20031222214430.066b3e4d.clauz@punkass.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> After batteling with lm_sensors on a new linux 2.6.0 kernel a couple
> of hours i realised that my W83627HF wasen't being recognized properly
> by 'sensors-detect' - It told to modprobe for W83682HF which in the
> 2.6.x series dosent exist since it has been merged into one driver or
> something (i don't have programming skills O_o ) (...)

That's actually the contrary. The w83627hf driver has been added to CVS
to better support the w836x7HF/THF chips, and has not been ported to
Linux 2.6.0 yet, so there's only the w83781d driver there, which happens
to partialy support the w836x7HF/THF family as well.

We'd need to port the w83627hf driver to 2.6.0 but we're all too busy
these days to do so. If you are willing to give it a try, I'll point you
to the docs explaining how to do that.

Thanks for the report anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

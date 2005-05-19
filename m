From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lib/proc.c update pending kernel patch?
Message-Id: <1073308234.3ff9624a0d5ad@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040105000918.GG30841@earth.solarsys.private>
In-Reply-To: <20040105000918.GG30841@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In the comments of lib/proc.c are these two lines:
> 
> 	temp%d_over -> temp_max%d (to be changed after kernel patch)
> 	temp%d_hyst -> temp_min%d ("")
> 
> Would anyone object if I change this code to... ?
> 
> 	temp%d_over -> temp_over%d
> 	temp%d_hyst -> temp_hyst%d
> 
> With Linux 2.6.1-rc1 out, that was the intention, right?

Yes, hyst should "point to" hyst in 2.6.1-rc1. But I don't think that
over should point to over. IIRC, there is no "over" files in 2.6
drivers, but "max" files, so I don't think there is anything to change
here (or in other words: I think this comment was bogus).

As a side note, there is still a temperature magnitude bug in w83781d in
2.6, which is "fixed" by exceptions in libsensors. This would need to
be fixed more cleanly, and it would be great to do it before Linux
2.6.1 and lm_sensors 2.8.3 are released. I'll give it a try tomorrow
evening, but anyone feel free to go before I do.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

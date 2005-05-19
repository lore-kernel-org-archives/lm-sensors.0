From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Cannot have lm-sensors work with my NV7m ABIT motherboard
Message-Id: <20030322143726.3f555d8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048326224.4015.63.camel@Ordiyann>
In-Reply-To: <1048326224.4015.63.camel@Ordiyann>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I own a ABIT NV7m motherboard with a AMD ATHLON CPU, based on the
> nVIDIA nForce 420D chipset. The built-in chip appears to be a Winbond
> W83627HF, which is normally supported by lm-sensors.
> 
> But when I do sensors-detect (as root), here is what I get:

(...)

It looks like you had some drivers already loaded when you ran
sensors-detect, and it confused the script. So, please first unload all
sensors-related modules (using rmmod, and check with lsmod), issue a
"depmod -a" just to make sure, and run sensors-detect again. Do *NOT*
answer yes when asked about non-detectable adapters. Your adapter is on
the PCI bus, it is known and you probably don't have anything else
(nothing useful anyway).

Let us know what happens then.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

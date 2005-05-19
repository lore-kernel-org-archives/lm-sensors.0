From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: Testing ASUS PU-DLS
Message-Id: <20030513160441.3a0765d0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1052831030.613.28.camel@zrr>
In-Reply-To: <1052831030.613.28.camel@zrr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I downloaded the packages.

Which packages?

> In ../modules I done 'make all'
> 
> and I get:
> grep: /usr/src/linux/.config: No such file or directory
> make: *** No rule to make target `linux/modversions.h', needed by
> `kernel/chips/vt1211.d'.  Stop.
> 
> Why would that be?

Looks like you are missing kernel sources, but I hardly can help more
unless you explain in details what you have being doing, where you want
to go and what's in the way.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: it87
Message-Id: <20030729155544.6304403a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00d101c355ba$c10cb7a0$c8de11cc@black>
In-Reply-To: <00d101c355ba$c10cb7a0$c8de11cc@black>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mike,

> I've added the it87 chip to sensord in prog/sensord/chips.c.  Been
> working for a few days now. Patches attached.

Thanks for the patch. Just a quick question. You added a function
fmtTemps_2 (and don't even use it) which seem to be the very same as the
fmtTemps_1 function. What's the big idea?

Also, you display one decimal place for the current temperature while
the it87 does only report integer values AFAIK.

The rest seems to be OK and will be applied.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

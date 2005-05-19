From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: I2C crash - ADM1021
Message-Id: <20031013215431.4128be1d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> see attached file.  Not sure what it shows.

It shows why my code was not working. I expected 0x0000s, while these
are 0x3f00s. BTW, this could mean that this unknown chip expects to be
read in word mode, which is rather unusual (still I don't know what it
could be).

Oh, I took a look at the latest 0x18 dump you sent, it is different from
the very first dump you made, which means this chip is alive too - and I
don't know what this one is either.

I've fixed sensors-detect in CVS, it know should ignore your chip at
0x4e. If you have some time left to give it a try (again), that would be
nice :) Now I hope we won't miss real LM75s. I tested on the one I own
and it is still working, so I'm confident.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

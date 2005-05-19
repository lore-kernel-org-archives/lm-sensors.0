From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/lib data.c init.c
Message-Id: <20031203071733.49b7c9ad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031124212556.1deac3be.khali@linux-fr.org>
In-Reply-To: <20031124212556.1deac3be.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > There still are three of them in the library, but it's in the
> > generated parser code. I just can't read this, so I will be unable
> > to fix them. If anyone with more knowledge of bison/flex could
> > tackle this, I'd of course help.
> 
> Interesting.  Did you use valgrind to find these?

Yes I did. I also used it to locate and fix bad memory
allocation/accessses in dmidecode (2.x) and associated tools. This is a
really helpful tool and I'd recommend it to everyone.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

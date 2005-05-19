From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: compile bug workaround (ticket 1344)
Message-Id: <20031027223311.5b3491af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031026224736.GA6514@avalon.gci.net>
In-Reply-To: <20031026224736.GA6514@avalon.gci.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I had the exact same problem as the poster in ticket 1344.  The poster
> offered a workaround which is not very clean.  I improved the
> workaround a bit: I switched module compilation on, and did a "make
> user".  I then copied sensors.h to sensors.h.bak.  After that, I did a
> "make clean", restored sensors.h from the backup, turned module
> compilation back off, and did another "make user".  The compilation
> went fine then.

Well, the bug is fixed in our latest release (2.8.1) anyway.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Tickets #1322 and #1323
Message-Id: <20030708104802.3c07a0f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030708093213.642bde1a.khali@linux-fr.org>
In-Reply-To: <20030708093213.642bde1a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I get the file:
> 
> # wget
> # http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/Makefile

You should have used
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/Makefile instead. The
browser adds line numbers, which is a real pain if you just want to
replace a distribution file by its CVS counterpart.

> but  I  deleted  the  SPACES  on  line 257 and 259 and I have inserted
> instead of them TABS and all is working.

Great.

> make help give to me the same error as before (257 missing)

My mistake of course, make actually parses the whole file before
running, and complains there. That's why it even prevented you from
compiling while the "error" was in the "make install" part.

> NOW  with  the  tabs  all  works fine, in the next time I will get the
> files only with cvs command

Probably the better you can do, right. By the way, would you have some
time to try our complete CVS packages? We're about to release and
testers are very welcome!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

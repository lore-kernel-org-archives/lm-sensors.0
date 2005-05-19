From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: 2.7.0 Error in make
Message-Id: <20030120205027.0937a3b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E2C49C0.705@moment.net>
In-Reply-To: <3E2C49C0.705@moment.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > bison -p sensors_yy -d lib/conf-parse.y -o lib/conf-parse.c
> > make: bison: Command not found
> > make: *** [lib/conf-parse.c] Error 127

You need to install bison. It is packaged for most (if not all)
distributions. On some distributions, you have to look for yacc instead.
Just find a package that provides bison, as a binary or as a symbolic
link to yacc, and you're done.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

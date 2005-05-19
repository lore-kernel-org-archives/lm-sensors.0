From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Release 2.8.6
Message-Id: <20040404231057.16f008ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040404095054.0e28c7da.khali@linux-fr.org>
In-Reply-To: <20040404095054.0e28c7da.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK, let me know when you are ready.

Well, my tests are all OK, except one brokenness in sensors-detect but
it's not critical and I have no trivial fix (the script tries to load
modules that are already loaded because dashes are replaced by
underscores in /proc/modules).

So I'm OK for a release. I know we have been having many testers on CVS
recently because mm and rc kernels were needing it, so I'm confident if
it working well. Let's go!

> BTW- I was just browsing the 2.6.5 changelog.  Lots of I2C patches!
> Nice work!

Thanks :)

NB: As usual, lib version is already bumped.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

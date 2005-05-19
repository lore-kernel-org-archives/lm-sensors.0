From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: stdarg.h inclusion problem (ticket #1343)
Message-Id: <20030721231224.48e24a18.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058736432.30749.4.camel@kalaha>
In-Reply-To: <1058736432.30749.4.camel@kalaha>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> But it did'nt work, always the same error, even if I seet my locales
> by hand just before.

Do you have sed installed on your system? Which  version is it?

What does the following command return is run from a shell?
LC_ALL=C gcc -print-search-dirs | sed -ne 's/install: \(.*\)/-I
\1include/gp'

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

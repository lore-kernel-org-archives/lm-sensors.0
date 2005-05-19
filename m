From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (really almost solved)
Message-Id: <20030730120155.73615efa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307292322.53518.ondrej.cecak@centrum.cz>
In-Reply-To: <200307292322.53518.ondrej.cecak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> btw: is possible send emails with attachment to sensors@...?

Yes it is. HTML is prohibited but reasonably-sized attachements are OK.

OK, looks like you have DRDRAM (aka Direct Rambus) RIMMs. 2 modules of
256MB each, right? That kind of memory is supposed to be found on
laptops, which isn't your case IIRC. Strange...

Anyway, I added support for DRDRAM to sensors, and to detect-dimms.pl
too (just the name, only DIMMs are really supported). Feel free to give
it a try, and feedback will be appreciated if you do so.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

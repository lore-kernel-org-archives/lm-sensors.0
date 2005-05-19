From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: rounding issues (ticket 1326)
Message-Id: <20030729175704.2f7fbee6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Some times ago, you contacted us about a rounding issue in our w83781d
driver. I commited a fix to CVS and send it to you too, asking you to
test it and tell us how it works.

We never heard you back though. I'd really like you to test it. There
are still seven other drivers that probably would require the same kind
of fix, and I don't want to change them before having some feedback from
you.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

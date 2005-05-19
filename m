From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: tickets 1511 and 1522 (HZ)
Message-Id: <20040117190618.5f87cce8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Tickets 1511 and 1522 refer to a compilation problem.
http://secure.netroedge.com/~lm78/readticket.cgi?ticket11
http://secure.netroedge.com/~lm78/readticket.cgi?ticket22

After a few exchanges with both users I could find the following. Looks
like both users have some additional (2.4) kernel patch that makes HZ
resolve to get_hz() instead of an integer value. This causes trouble
because this isn't allowed in struct initializations. I see three
possibilities:

1* This isn't the vanilla kernel, we don't support it.

2* We move the initialization of anything with HZ in it out of the
structure declarations.

3* We use USER_HZ instead of HZ when USER_HZ is defined (which is the
case with the mysterious patch, USER_HZ is 100).

Opinion anyone?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

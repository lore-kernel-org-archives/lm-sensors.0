From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Tickets tickets 1511 and 1522
Message-Id: <20040117211853.788f8cc7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys,

It turns out that SuSE 9.0 pro includes some special kernel patche that
define HZ as a function instead of an integer constant. This is what
causes the compilation trouble you reported. We don't plan to support
this since it isn't part of the vanilla kernel.

So you have two choices left:
1* Use SuSE lm-sensors packages.
2* Replace any occurence of HZ in our code by 100 and see how it is
going this way. No guarantee of any sort, of course.

I'll be closing the tickets now.
Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

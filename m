From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: ticket 1599 explanation
Message-Id: <20040306182153.295ae36e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040306020526.50077.qmail@home.pl>
In-Reply-To: <20040306020526.50077.qmail@home.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It works !! Thanks!!

Great :)

> There was a problem with line 10 of patch:
> 
> patching file src/i2c-riva.c
> patch: **** malformed patch at line 10: };
> 
> But I replaced two lines manually and now everything works great.

I guess that your mail client broke the inline patch... Well, as long as
you got it to work :)

I've submitted a bug report to the rivatv folks, with that patch, so
that they can "correct" it in CVS too (also I wouldn't call this a bug
of theirs).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

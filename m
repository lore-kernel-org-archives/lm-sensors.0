From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Problmem report
Message-Id: <20030615122703.56e9d4aa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EEB9F68.4040308@yahoo.fr>
In-Reply-To: <3EEB9F68.4040308@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> sensors reports null values. see attached files for details.
> Contact me if you need further details.

OK, I took a look at your files. Your I2C bus has gone mad for some
reason. The sensors-detect script finds way too many sensors, you can't
possibly have them all.

The problem you encountered may be related to another issue I'm
currently working on. I need the answer to the following questions:

1* Which version of Perl is your system running. I guess 5.8.0. The
exact package version would be appreciated (so that I can check if
Mandrake added some patches).

2* Is your Mandrake system UTF8-aware?

3* If the answer to question #2 is yes, are you using an UTF8 locale?
Check with "locale" (send me the command output in any case).

With these answers, I may have some ideas to investigate one step
further.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

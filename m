From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm90 driver
Message-Id: <20031026170343.31a393c3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030906000353.40951246.khali@linux-fr.org>
In-Reply-To: <20030906000353.40951246.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I'm glad it works so well :) Just to make sure I understand it well,
> > the it87 was on a completely different system, right?
>
> No.  I have a Soyo Dragon Ultra (KT400) that has both.

Oh, OK, this make sense now. The LM90 and the IT87 must be measuring the
temperature of two different points of the motherboard. Temperature
varies a lot in a computer case, so that's no wonder both sensors return
different values.

> As I said in my supplemental e-mail, after about 30 seconds of
> troubleshooting on the tv card issue, I realized the permissions on my
> video device were wrong, so there is no problem.  The only problem I
> did have was that Mandrake installs lm_sensors into /usr/lib and the
> default location when installing from source is /usr/local/lib.  So I
> had to add that path to /etc/ld.so.conf before running ldconfig.

That's a rather usual issue. Most distributions don't really expect
people to install things to /usr/local because all "official" packages
use /usr. Still I believe they *should* add /usr/local/lib to their
ld.so.conf file, so that new users trying to install a piece of software
by themselves for the first time do not have to struggle with libraries
not being "detected".

Thanks for the details. Feel free to contact us later if you have
problems or suggestions WRT sensors on your Linux systems.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030816135220.4e6a5e98.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806233617.5a83d0b6.khali@linux-fr.org>
In-Reply-To: <20030806233617.5a83d0b6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > Why?  Just check for CAP_SYS_ADMIN if the Vaio is detected.  If
> > > that succeeds, then give access, otherwise deny it.

OK, that's done and tested OK (for me). Feel free to take a look if you
want (it's straightforward anyway).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

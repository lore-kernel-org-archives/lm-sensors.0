From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: ADM1032 die revision code
Message-Id: <20030830225705.5f8dea91.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mary,

We are planning to add support for the ADM1032 to our hardware
monitoring program. In order to do so, we would need to be able to
identify the ADM1032. The problem is that the data sheet doesn't give us
the die revision code for the ADM1032. It says: "Undefined". I can't
believe it is actually undefined. It wouldn't make sense to define a
register to hold such a value and not to define that value, isn't it?

I hope you'll be able to get this information back to us so that we have
a reliable ADM1032 detection routine, and can then work on fully
supporting it.

Thanks a lot.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

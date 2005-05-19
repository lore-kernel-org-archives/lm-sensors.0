From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Ticket 1447 Update...Success...
Message-Id: <20031124203316.654f4f51.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B8BD20F161298A42A3B513D23A28556701101F2E@fsglenex3.schriever.af.mil>
In-Reply-To: <B8BD20F161298A42A3B513D23A28556701101F2E@fsglenex3.schriever.af.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Just wanted to drop a note...I had an issue documented on ticket 1447.
> The CVS build v2.8.2 has resolved the issue.  I just wanted to let you
> al know of my success on getting this built with this hardware...

Great :)

On the ticket, I could see that the eeprom module reports an unknown
type. What kind of memory do you have? Could you please provide a dump?
Which capacity?
("i2cdump 0 0x50" and "i2cdump 0 0x51").

> Thanks again...

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

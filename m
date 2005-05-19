From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: CVS (Was: Tickets #1322 and #1323)
Message-Id: <20030708110554.791fcc87.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Probably the better you can do, right. By the way, would you have
> > some time to try our complete CVS packages? We're about to release
> > and testers are very welcome!
> 
> yes, of course!
> 
> I use this commands, it's ok?
> 
> cvs -d :pserver:anon@cvs.lm-sensors.nu:/home/cvs login
> cvs -d :pserver:anon@cvs.lm-sensors.nu:/home/cvs checkout lm_sensors2
> cvs -d :pserver:anon@cvs.lm-sensors.nu:/home/cvs checkout -r lk2-4 i2c

Looks OK, yes. Don't forget you have to install i2c before compiling
lm_sensors2, contrary to what the lines above could make you think.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

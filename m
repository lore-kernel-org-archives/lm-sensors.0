From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Trouble accessing CVS
Message-Id: <20030812195922.4ff7f670.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Could you perhaps pack the latest CVS release and mail it to me or 
> something else?
> I am most likely not allowed to access CVS by my firewall. 
> I am logged into a machine at work from home so I cant disable the 
> firewall. 
> 
> >cvs -d :pserver:anon@cvs.lm-sensors.nu:/home/cvs login
> (Logging in to anon@cvs.lm-sensors.nu)
> CVS password: 
> Unknown host cvs.lm-sensors.nu.

This is an error I also got sometimes, but it never lasts. I guess our
DNS isn't the best quality one could imagine.

If you still can't connect, I've made a copy of my repository available
there:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/snapshots/

Thanks for testing.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

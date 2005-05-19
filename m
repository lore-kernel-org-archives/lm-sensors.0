From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Works great first. After restart do not work.
Message-Id: <20030306174822.7ff7d994.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> After installing and runing is works great using adm 1024.
> Then when I do a shutdown -r now, It does not work anymore. Below is
> what I get.
> (...)
> What am I doing wrong?

I'd say you either forgot to run "sensors -s" or loaded the wrong
modules.

Try with "sensors -s" first. If it doesn't work, try rerunning
sensors-detect and make sure you are using the modules that were
suggested.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

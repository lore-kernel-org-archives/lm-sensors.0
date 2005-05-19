From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030628092142.0a9c1722.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Could be... But there is one last thing I would like to try. My
> > changes(-k3) don't seem to have had any effect, so I'm trying
> > something similar but different. Please get
> >   http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k4
> > and tell me, again, it it behaves differently with and without an
> > UTF-8 locale.
> 
> That seemed to fix it!!!

"Ah ah ah (evil laugh) you nasty little bug, you thought you could lurk
forever? Diiiiiiiie!"

Ahhhh I feel better :) For the ones interested, the solution was to call
binmode(IOPORTS, ':raw') after opening '/dev/ports'. The ':raw' keyword,
among other things, prevents Perl from using the UTF-8 layer on file I/O
(where available). I did not find this first because I don't have Perl
5.8.0 on my development machine, and this layers thing is new in 5.8.0.
I was told on IRC to have a look at the binmode perldoc page on Perl
5.8.0, which I did, and it led me to the solution.

Ok Jim, thanks a lot for your help again. I'll commit a clean fix to
sensors-detect to CVS today.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

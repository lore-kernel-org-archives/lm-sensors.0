From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: lm_sensors ain't updating cpu temp
Message-Id: <20040901193248.09558c13.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093792983.3809.5.camel@84.xa.interkam.pl>
In-Reply-To: <1093792983.3809.5.camel@84.xa.interkam.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Things to try:
> > 
> > 1* Cycle the w83781d driver (as root):
> > $ rmmod w83781d
> > $ modprobe w83781d
> > And see if temp2 changes.
> 
> Did not help.
> 
> > 2* Try to pass init=0 to the w83781d module:
> > In the file /etc/modprobe.conf, add the following line:
> > options w83781d init=0
> > I just hope that this file is not generated from other files on your
> > system. If it is, you'll have to find out which files this one is
> > generated from, and edit one of them instead.
> > Then reboot your computer and see if it helps.
> > 
> > I can't remember a similar report so far (by my memory is rather
> > weak).
> 
> Did not help.

Well, I'm out of ideas then. Only thing I can suggest is try a more
up-to-date kernel package when Mandrake releases one, maybe it'll
somehow help.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

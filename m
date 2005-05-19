From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: gnome-settings-daemon restartet to often
Message-Id: <20030804144253.5dd97e80.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030804061411.11921.qmail@debian>
In-Reply-To: <20030804061411.11921.qmail@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > No. I don't use Gnome myself. If you can get more detailed
> > information in the log, it would help.
>
> What should I look for in witch log?

/var/log/syslog, /var/log/messages, or any gnome-specific log (I don't
know their names, I don't even know if there are any).

> PS: I reinstalled gnome2 from a different source and now when I get
> into gnome 'mozilla-bin' just about crashes my computer because it
> starts so many sessions (I believe). 

As said before, this is unlikely to be related to lm_sensors. I'm of
course sorry for you that your system broke at the same time you were
trying to get lm_sensors to work, maybe there is some obscure relation
between both things, but can't do much more than I already did.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

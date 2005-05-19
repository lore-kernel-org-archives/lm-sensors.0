From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: ticket #1291
Message-Id: <20030731124808.4036b60c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030731110954.43f2f54e.khali@linux-fr.org>
In-Reply-To: <20030731110954.43f2f54e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Maybe you need an additional header and library to get inb and outb
> > on PPC. Could you please run the following commands and report
> > outputs?
> > 
> > grep '^inb ' -r /usr/include/*
> this gives me:
> grep '^inb ' -r /usr/include/*
> grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive
> Verzeichnisschleife.
>  
> grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links
> 
> > grep '^outb ' -r /usr/include/*
> this gives me:
>  grep '^outb ' -r /usr/include/*
> grep: Warnung: /usr/include/gnome-xml/libxml: Rekursive
> Verzeichnisschleife.
>  
> grep: /usr/include/ioport.h: Zu viele Ebenen aus symbolischen Links

First, you really should fix the two warnings that show up. It's about
bad symlinks if I understand german right.

Second, the grep commands did not find any inb or outb defs, let's try
with a different regexp:

grep ' inb' -r /usr/include/*
grep ' outb' -r /usr/include/*

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: gnome-settings-daemon restartet to often
Message-Id: <20030804113700.0e7c476b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030804061411.11921.qmail@debian>
In-Reply-To: <20030804061411.11921.qmail@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I note the following problems on my Debian PPC:
>  -the panel does not start up. In the beginning I get 'Gnome settings
>  daemon 

Maybe the Gnome settings daemon deals with sensors in some way (just a
wild guess) and fails because it's badly installed. Without a more
precise error message, it's hard to say.

> has been restartet to often' - 'will try to restart at next reboot...'
>  -When I hit the reply button on my sylpheed-claws my sylpheed-claws
>  crashes 
> telling me that it does not find the german language file:
> Unhandled Error: /usr/lib/aspell//de-only.rws: The language "de" is
> not known. This is probably becuase the file
> "/usr/local/share/aspell/de.dat" can not be opened for reading.
> Abgebrochen
> in fact: all that is installed. 

This is definitely *not* related to us. If it happened at the time you
installed lm_sensors, it may be pure coincidence, or you are having
serious HDD issues.

Try "chmod 644 /usr/local/share/aspell/de.dat", just in case.

> I am no trying to install a newer kernel version, lets see if that
> helps or not... 

I don't think it will, but who knows... Your system is strange, really.

> Any hints regarding my 'Gnome settings daemon'? 

No. I don't use Gnome myself. If you can get more detailed information
in the log, it would help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

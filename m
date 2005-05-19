From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: Not able to get it working...
Message-Id: <20030412102530.77174c06.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030412012942.50109.qmail@web13807.mail.yahoo.com>
In-Reply-To: <20030412012942.50109.qmail@web13807.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have attached the dmesg output; lsmod does not
> appear to exist. I have attached the output of
> sensors-detect as I reran it just before.
> (...)
> As one note, I have not run `modprobe -a': I tried,
> but there does not seem to be a modprobe.

Theses are the tools we can't live without. You probably won't have any
sensors working (and actually I wonder how you can have a working system
at all). So you have to fix this problem first. These tools are usually
included in a package named "modutils" or something similar. Look for
any suitable package from your distribution, and have it installed.
Then, and only then, after you issued a "depmod -a", sensors-detect will
possibly be of some help (though the preliminary output suggests you
don't have any supported device).

There's nothing we can do until you have the modutils installed. Come
back to us when there're installed and working.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

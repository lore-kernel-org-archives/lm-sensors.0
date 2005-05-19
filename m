From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (almost solved)
Message-Id: <20030729145721.016f67db.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030727233434.568d9d4c.khali@linux-fr.org>
In-Reply-To: <20030727233434.568d9d4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> ACPI from current Marcelo's kernel (2.4.21) don't work, I'm curious to
> new ACPI in kernel 2.4.x (maybe 22, but evidently 23) ...

The ACPI support in 2.4.x is really thin so far, you really have to use
the ACPI patch if you want real support:
http://sourceforge.net/project/showfiles.php?group_id6832&release_id1534
That's what I use (well, the previous version actually) on my laptop.

> It works perfectly. Maybe I made mistake, becase ran gkrellm made Oops
> ... I detected it after I mailed you. 

Oops are at kernel level, so if gkrellm made oops, it's likely to be
because of one of our drivers... Let us know if it happens again.

> > The limits are still a bit too low, probably a common rounding
> > issue, I'll take a look at it tomorrow (and probably ask you to test
> > then, if you don't mind).
> 
> with pleasure, but in Czech Republic is now 23:49 ;-))))

Was the same here, Czech Republic and France are in the same time zone
:)

OK, I updated the driver. I would like you to checkout from CVS this
time (because more than just one file was changed). You don't have to
checkout i2c (but you are welcome to do so if you wish, since some bugs
were fixed since 2.8.0 was released). Don't forget to run "ldconfig"
after installation of lm_sensors, since I bumped the library revision.
Also, you will want to manually update the sensors.conf file (I added
various comments to the adm1025 section).

How to get CVS checkouts is described on our download page:
http://secure.netroedge.com/~lm78/download.html#cvs

If you can't use CVS for any reason, I can make a snapshot available to
you as a simple tar.gz file.

Thanks for testing! This is very very appreciated :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors program library problems (more info)
Message-Id: <20030721151020.7fb3c44b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058790834.16392.3.camel@farrell.freemans.org>
In-Reply-To: <1058790834.16392.3.camel@farrell.freemans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> after thinking a little, i thought perhaps it was a problem with my
> PATH variable... so:
> 
> [upgrdman@farrell upgrdman]$ sensors
> sensors: error while loading shared libraries: libsensors.so.2: cannot
> open shared object file: No such file or directory
> [upgrdman@farrell upgrdman]$ su -c updatedb
> Password:
> [upgrdman@farrell upgrdman]$ locate libsensors.so.2
> /usr/local/lib/libsensors.so.2.0.0
> /usr/local/lib/libsensors.so.2
> /home/upgrdman/lm_sensors-2.8.0/lib/libsensors.so.2.0.0
> /home/upgrdman/lm_sensors-2.8.0/lib/libsensors.so.2
> [upgrdman@farrell upgrdman]$ echo $PATH
> /usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/upgrdman/bin
> [upgrdman@farrell upgrdman]$ export PATH=$PATH:/usr/local/lib
> [upgrdman@farrell upgrdman]$ echo $PATH
> /usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/upgrdman/bin:/usr/l
> ocal/lib[upgrdman@farrell upgrdman]$ sensors
> sensors: error while loading shared libraries: libsensors.so.2: cannot
> open shared object file: No such file or directory
> (...)
> still no success :(

You were close, but did something wrong. PATH is for binaries, not libs.
(You should have noticed that all the other strings in PATH end with
/bin, not /lib.)

The /usr/local/lib directory is probably not used by your system, we
have to teach it it should ;) As root, edit /etc/ls.so.conf and add one
line that says: "/usr/local/lib". Save, quit and run "ldconfig". Now
sensors should work.

BTW, lm_sensors's "make install" should have detected this, and has
probably warned you, and told you to just what I told you to do. Didn't
you pay attention at that time?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

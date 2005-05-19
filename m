From: raj@ast.man.ac.uk (Richard James)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Ticket number 1467
Message-Id: <Pine.OSF.4.53.0312142109070.20427@axp0.ast.man.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031210225306.55ceb34e.khali@linux-fr.org>
In-Reply-To: <20031210225306.55ceb34e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

	Thanks for your message - 2.8.2 works "out of the box", albeit
after I edited the sensors.conf file that came with it to select rev 2
rather than rev 1.  I find it comforting that the selection of the chip is
more precise in the new version.

	Very best wishes,

			Richard.

On Fri, 12 Dec 2003, Jean Delvare wrote:

> > 2)	For version 2.8.0 I did manage to realise that I needed
> > /proc/sys/dev/sensors w83782d-i2c-0-2d (why not w83781d....?
> > - beyond me!) so I attach results from there.
>
> The w83781d driver handles more than only the W83781D driver. It also
> supports, among others, the W83782D and the AS99127F (revisions 1 and
> 2). The W83782 and the AS99127F revision 2 are almost the same chip and
> can be handled almost the same way. In 2.8.0 we weren't differenciating
> them (which is why your AS99127F was detected as a W83782D).
>
> > Version 2.8.0 - from /proc/sys/dev/sensors/w83782d-i2c-0-2d:
> >
> > in5:   0.33 0.78 0.54
> > in6:   0.78 0.94 0.83
> >
> > Version 2.8.1 - from /proc/sys/dev/sensors/as99127f-i2c-0-2d:
> >
> > in5:   2.70 3.33 0.54
> > in6:   3.15 3.49 0.83
>
> As you can see, the readings (last value for each input) are the same -
> which confirms it was a problem with how conversions are done by the
> library, and not a driver issue.
>
> > 3)      I downloaded the lm_sensors2... stuff from the site you
> > gave me - the lm_sensors.. stuff was marked as old code.  I
> > managed to compile it, after commenting out some chip IDs which
> > were not recognised and to install it in /lib/modules but could
> > not run sensors -s.  The error message was
> >
> > Error: Line 2: Invalid keyword.
> > General parse error.
>
> I don't understand what you did. All I told you to get was the updated
> configuration file. You were not supposed to download a full package nor
> to compile anything.
>
> > Many thanks for your help - it is really appreciated.
> > Please let me know if I have picked up the wrong code!
>
> You obviously did. The file you need is this one only:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg
> Download it, copy it to /etc/sensors.conf and you are done.
>
> BTW, version 2.8.2 has been released today, if you want to give it a
> try. If you do, you don't even have to get the file above.
>
> Good luck.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>

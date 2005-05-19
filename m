From: raj@ast.man.ac.uk (Richard James)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Ticket number 1467
Message-Id: <Pine.OSF.4.53.0312121952100.13830@axp0.ast.man.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031210225306.55ceb34e.khali@linux-fr.org>
In-Reply-To: <20031210225306.55ceb34e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

        Thanks for your message - the results of your
suggestions are below:

1)      Yes - the relevant extract from sensors-detect is copied
(manually!) below:

Driver 'w83781d' (should be inserted)
  Detects correctly:
  * Bus 'SMBus I801 adapter at e800' (Non-I2C SMBus adapter)
    Busdriver 'i2c-i801', I2C address 0x2d (and 0x48, 0x49)
    Chip 'Asus AS99127F (rev 2)' (confidence: 8)

2)	For version 2.8.0 I did manage to realise that I needed
/proc/sys/dev/sensors w83782d-i2c-0-2d (why not w83781d....?
- beyond me!) so I attach results from there.

Version 2.8.0 - from /proc/sys/dev/sensors/w83782d-i2c-0-2d:

in5:   0.33 0.78 0.54
in6:   0.78 0.94 0.83

Version 2.8.1 - from /proc/sys/dev/sensors/as99127f-i2c-0-2d:

in5:   2.70 3.33 0.54
in6:   3.15 3.49 0.83

3)      I downloaded the lm_sensors2... stuff from the site you
gave me - the lm_sensors.. stuff was marked as old code.  I
managed to compile it, after commenting out some chip IDs which
were not recognised and to install it in /lib/modules but could
not run sensors -s.  The error message was

Error: Line 2: Invalid keyword.
General parse error.

I have no idea which file generated this message.  I plan to look
at the site again and check that there are no more recent
packages to download.

        Many thanks for your help - it is really appreciated.
Please let me know if I have picked up the wrong code!

                Best wishes,

                        Richard James.

On Thu, 11 Dec 2003, Jean Delvare wrote:

> > < clip >
> > > Version 2.8.0:
> > > w83782d-i2c-0-2d
> > <clip>
> > > Version 2.8.1:
> > > as99127f-i2c-0-2d
> >
> > Just wanted to point out that the 2.8.0 printout was for w83782d,
> > while 2.8.1 was for as99127f. So different compute rules in
> > sensors.conf were applied.
>
> Stupid me. Thanks for the notice.
>
> Richard, do you confirm that recent versions of sensors-detect tell
> you you have a revision 2 AS99127F?
>
> I've checked an improved version of sensors.conf in our CVS repository.
> Get it here:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg
>
> Copy it to /etc/sensors.conf, and edit the "as99127f-*" section. You'll
> find commented out lines for AS99127F rev.2 in5 and in6. Uncomment them
> and you're (hopefully) done.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>

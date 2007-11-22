From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Nov 2007 20:09:05 +0000
Subject: Re: [lm-sensors] PATCH: fix building of 3.0.0-rc3 on powerpc and
Message-Id: <20071122210905.38d81feb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <473ECD90.5090603@hhs.nl>
In-Reply-To: <473ECD90.5090603@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 21 Nov 2007 21:46:43 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Good catch, thanks. I'd rather address the problem in the top Makefile:
> > there's no point in including prog/dump in the list of source
> > directories if we won't build anything there. So I'd suggest something
> > like:
> > 
> > ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
> > SRCDIRS += prog/dump
> > endif
> > 
> > in the top Makefile. Then you can even remove the architecture tests
> > in prog/dump/Module.mk, as they will be redundant, and clean up that
> > file a bit.
> > 
> 
> mm, so I came up with the attached patch, but for some reason that does not 
> work as MODULE_DIR gets set to prog/dump when executing install-etc on 
> platforms which do include isadump like x86_64:
> 
> mkdir -p /var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/etc
> if [ ! -e 
> /var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/etc/sensors3.conf ] ; then \
> 	  install -m 644 etc/sensors.conf.eg 
> /var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/etc/sensors3.conf; \
> 	fi
> mkdir -p /var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/usr/bin
> install -m 755 prog/dump/sensors-conf-convert 
> /var/tmp/lm_sensors-3.0.0-0.1.rc3.fc9-root-kojibuilder/usr/bin
> install: cannot stat `prog/dump/sensors-conf-convert': No such file or directory
> make: *** [install-etc] Error 1

There was an unrelated bug in etc/Module.mk, which your changes
uncovered. Sorry about that. It is fixed in SVN now, please give it a
try again. Your patch looks OK to me, so if no other problem arises,
please commit it to SVN.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

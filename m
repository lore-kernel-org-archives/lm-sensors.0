From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH] Fix lm_sensors installation with DESTDIR
Message-Id: <3FDB9486.689E7EB5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213202108.GF1976@sirius.home>
In-Reply-To: <20031213202108.GF1976@sirius.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks - applied.
you're welcome to test our package _before_ we release next time :)

Sergey Vlasov wrote:
> 
> Hello!
> 
> The new lm_sensors-2.8.2 has some bugs in the newly added Module.mk
> files, therefore "make install DESTDIR=something" does not work.
> 
> This patch fixes the problem:
> 
> --- lm_sensors-2.8.2/prog/pwm/Module.mk.install-fix     2003-10-28 04:41:47 +0300
> +++ lm_sensors-2.8.2/prog/pwm/Module.mk 2003-12-13 22:53:00 +0300
> @@ -22,7 +22,8 @@
>                    $(MODULE_DIR)/pwmconfig
> 
>  install-prog-pwm: $(PROGPWMTARGETS)
> -       $(INSTALL) -o root -g root -m 755 $(PROGPWMTARGETS) $(SBINDIR)
> +       $(MKDIR) $(DESTDIR)$(SBINDIR)
> +       $(INSTALL) -o root -g root -m 755 $(PROGPWMTARGETS) $(DESTDIR)$(SBINDIR)
> 
>  user_install :: install-prog-pwm
> 
> --- lm_sensors-2.8.2/prog/xeon/Module.mk.install-fix    2003-11-29 16:29:59 +0300
> +++ lm_sensors-2.8.2/prog/xeon/Module.mk        2003-12-13 22:53:40 +0300
> @@ -21,7 +21,8 @@
>  PROGXEONTARGETS := $(MODULE_DIR)/decode-xeon.pl
> 
>  install-prog-xeon: $(PROGXEONTARGETS)
> -       $(INSTALL) -o root -g root -m 755 $(PROGXEONTARGETS) $(BINDIR)
> +       $(MKDIR) $(DESTDIR)$(BINDIR)
> +       $(INSTALL) -o root -g root -m 755 $(PROGXEONTARGETS) $(DESTDIR)$(BINDIR)
> 
>  user_install :: install-prog-xeon
> 
> --- lm_sensors-2.8.2/prog/eeprom/Module.mk.install-fix  2003-11-29 16:29:59 +0300
> +++ lm_sensors-2.8.2/prog/eeprom/Module.mk      2003-12-13 22:53:00 +0300
> @@ -23,7 +23,8 @@
>                       $(MODULE_DIR)/decode-vaio.pl
> 
>  install-prog-eeprom: $(PROGEEPROMTARGETS)
> -       $(INSTALL) -o root -g root -m 755 $(PROGEEPROMTARGETS) $(BINDIR)
> +       $(MKDIR) $(DESTDIR)$(BINDIR)
> +       $(INSTALL) -o root -g root -m 755 $(PROGEEPROMTARGETS) $(DESTDIR)$(BINDIR)
> 
>  user_install :: install-prog-eeprom
> 
> 
> Best regards,
> Sergey Vlasov
> 
> 
>    Part 1.2Type: application/pgp-signature

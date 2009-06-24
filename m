From: Konstantin Kletschke <konsti@ku-gbr.de>
Date: Wed, 24 Jun 2009 12:34:17 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090624123417.GC16923@punzenstreichler.doom>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

Am 2009-06-24 13:08 +0200 schrieb Luca Tettamanti:

> > Can fan pwm value controlled with this driver?
> 
> Not directly, the relevant ACPI method doesn't actually touch the
> hardware. It should be possible to use Q-FAN to switch between
> different profiles, but I've yet to RE that interface.

You mean the cooling profile (actually selectable in BIOS) could be
changed from acpi, if REed?

> > Does lm_sensors-3.1.0 still need to be patched to acces this driver?
> 
> No, it's fine as is.

Okay, so the my problem remains to access pwm2 which not seems to be
possible at the moment.

Regards, Konsti


-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

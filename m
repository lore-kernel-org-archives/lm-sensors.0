From: Konstantin Kletschke <konsti@ku-gbr.de>
Date: Mon, 29 Jun 2009 08:47:50 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090629084750.GF19175@punzenstreichler.doom>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 2009-06-25 11:21 +0200 schrieb Jean Delvare:

> Additional question: does the BIOS offer options to enable/disable
> automatic fan speed control? If so, please list them all, and check

Yes, the BIOS offer disabling Q-Fan and enabling it. If enabled I can
chosse between Turbo, normal or silent mode.

I use Q-Fan now enabled, when I switch it off the driver behaves
identical. 

> what is their effect on the pwm* values (including pwm*_enable)
> reported by the w83627ehf driver.

Also pwm*_enable shows "1" any time trying this.

Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

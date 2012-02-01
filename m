From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 01 Feb 2012 21:30:25 +0000
Subject: Re: [lm-sensors] [PATCH v5 2/5] x86/platform: (TS-5500) add GPIO support
Message-Id: <20120201213025.53d820d2@pyramind.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1328130344-18836-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1328130344-18836-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1328130344-18836-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: x86@kernel.org, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>

> +obj-$(CONFIG_TS5500_GPIO)		+= ts5500_gpio.o

Wants to be gpi-ts5500 and in the drivers/gpio directory.


Nothing else particularly strikes me abou tit

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

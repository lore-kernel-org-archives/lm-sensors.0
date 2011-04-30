From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 30 Apr 2011 10:20:36 +0000
Subject: Re: [lm-sensors] [RFC 5/5] hwmon: add support for Technologic
Message-Id: <20110430112036.1715b351@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1304115712-5299-6-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1304115712-5299-6-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, lm-sensors@lm-sensors.org

> +	ts5xxx_sbcinfo_set(&sbcinfo);
> +	if (5500 != sbcinfo.board_id && !sbcinfo.adc) {
> +		printk(MODULE_NAME ": Incompatible TS Board.\n");
> +		return -ENODEV

This is a symptom of creating the devices in the wrong place. If you put
all the ident/creation of boards in one place with the device creation
the drivers will cleanup and these ugly export things will go away

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

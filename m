From: Wim Van Sebroeck <wim@iguana.be>
Date: Thu, 24 May 2012 20:54:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Depend on watchdog for watchdog core functions
Message-Id: <20120524205426.GW3074@spo001.leaseweb.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-watchdog@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, linux-next@vger.kernel.org

Hi Hans,

> Since the watchdog code in sch56xx-common now uses the watchdog core, the
> Kconfig entires for the sch5627 and sch5636 should depend on WATCHDOG
> being set.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I added also the "select WATCHDOG_CORE" lines for both drivers.
In linux-watchdog-next now.

Kind regards,
Wim.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

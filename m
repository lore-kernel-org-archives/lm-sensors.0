From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Sep 2011 17:33:46 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] hwmon/sch5636: Add support for the
Message-Id: <1315848826.2455.193.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
	 <1315821420-16205-6-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315821420-16205-6-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

On Mon, 2011-09-12 at 05:57 -0400, Hans de Goede wrote:
> Add support for the watchdog integrated into the (Fujitsu Theseus version of)
> the sch5636 superio hwmon part. Using the new watchdog timer core.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/sch5636.c |  233 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 231 insertions(+), 2 deletions(-)
> 
[ resent to proper thread ]

Given that this is no longer a pure hwmon driver, it may make sense to
split it into separate mfd/hwmon/watchdog drivers. But on the other side
I notice that other drivers in the hwmon directory implement watchdog
functionality as well. Bad precedent :(. Wonder what happens with those
watchdogs if HWMON is disabled.

Not really sure if we should let this happen, or start being more
restrictive and enforce cleaner code. Jean, any thoughts/comments ?

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

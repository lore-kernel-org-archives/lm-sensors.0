From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Sep 2011 18:48:34 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] hwmon/sch5636: Add support for the
Message-Id: <1315853314.2455.207.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
	 <1315821420-16205-6-git-send-email-hdegoede@redhat.com>
	 <1315848826.2455.193.camel@groeck-laptop>
	 <20110912200302.28dbfdfd@endymion.delvare>
In-Reply-To: <20110912200302.28dbfdfd@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, LM Sensors <lm-sensors@lm-sensors.org>

On Mon, 2011-09-12 at 14:03 -0400, Jean Delvare wrote:
> On Mon, 12 Sep 2011 10:33:46 -0700, Guenter Roeck wrote:
> > On Mon, 2011-09-12 at 05:57 -0400, Hans de Goede wrote:
> > > Add support for the watchdog integrated into the (Fujitsu Theseus version of)
> > > the sch5636 superio hwmon part. Using the new watchdog timer core.
> > > 
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >  drivers/hwmon/sch5636.c |  233 ++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 files changed, 231 insertions(+), 2 deletions(-)
> > > 
> > [ resent to proper thread ]
> > 
> > Given that this is no longer a pure hwmon driver, it may make sense to
> > split it into separate mfd/hwmon/watchdog drivers. But on the other side
> > I notice that other drivers in the hwmon directory implement watchdog
> > functionality as well. Bad precedent :(.
> 
> IIRC the first driver doing this was one of the FSC drivers and this was
> before the MFD framework was created. It was simply never migrated, and
> other drivers followed the trend.
> 
> > Wonder what happens with those watchdogs if HWMON is disabled.
> 
> Then the watchdog feature isn't available. The idea as I understand it
> is that hardware monitoring is the main feature of these chips and
> watchdog is only an add-on, so we don't expect the user to want the
> watchdog feature without the hardware monitoring feature.
> 
> > Not really sure if we should let this happen, or start being more
> > restrictive and enforce cleaner code. Jean, any thoughts/comments ?
> 
> I have no objection to merging the code as is, as you found out it's not
> doing anything other drivers haven't already.
> 
> If anybody cares, that person can clean up one or more drivers, later.
> That being said, at least for I2C devices, I don't mind leaving things
> as they are, as doing things "better" means more complex code for very
> little benefit. For Super-I/O chips which are multifunction by nature,
> the MFD framework is certainly the right way to go.
> 
Makes sense.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Mar 2011 08:41:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add tachometer pulses per fan
Message-Id: <20110304094151.2b995eb6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299108238-14822-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299108238-14822-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 3 Mar 2011 17:01:18 -0800, Guenter Roeck wrote:
> On Thu, Mar 03, 2011 at 05:36:36PM -0500, Jean Delvare wrote:
> > I'm fine with this new attribute. We'll need support in libsensors too,
> > so that users can change the settings through configuration file +
> > "sensors -s".
>
> Ok. Note though that I still have the other changes (support for new attributes)
> pending against the sensors command.

Should be independent. For fan[1-*]_pulses you only need to touch
libsensors, not sensors, as the value doesn't have to be displayed
(well at least that's my opinion.)

Nevertheless, I'll try to review your sensors patch during the
week-end. And I'd like to release a new version of lm-sensors too...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

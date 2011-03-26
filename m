From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Mar 2011 17:16:00 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/3] hwmon: sht15: add support for
Message-Id: <20110326181600.71ce6d46@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 22 Mar 2011 07:28:56 -0700, Guenter Roeck wrote:
> On Tue, Mar 22, 2011 at 06:28:40AM -0400, Jonathan Cameron wrote:
> > On 03/22/11 00:00, Vivien Didelot wrote:
> > > Sure. After discussing about that, checksumming, otp_reload and
> > > *_resolution attributes have been removed. battery_alarm will be splitted into
> > > temp1_alarm and humidity1_alarm to respect the convention.
> > Really, Guenter / Jean is the is the right option?  The alarm isn't really about
> > either of the individual sensors, but rather about power to the chip?
> 
> I had suggested humidity1_alarm. Two alarms for one condition is overkill.
> I find it better to have a standard attribute which a standard program such as
> "sensors" may have a chance to display at some point. Jean may think differently - 
> we did not discuss the matter.

Sorry for joining a little late in the game. If I understand properly
the meaning of the "end of battery" status bit, humidity1_alarm is not
a suitable name. The *_alarm attributes are for off-limit measurements,
but the SHT1x has no limits in the first place. The "end of battery"
status bit means "measurements may be invalid", so I would map it to
humidity1_fault and temp1_fault. The later is already standardized, and
it would be easy to introduce the former. The usual meaning of
temp*_fault is a little different (broken / open / short sensor) but
its standard definition is fairly generic.

When the fault flag is set, "sensors" will display "FAULT" instead of
the measurement value, which is the right thing to do here if the
measurements are unreliable.

And there is nothing wrong with mapping a single register bit to two
attributes, if it makes sense as is the case here. I think we already
did it in the past for other chips.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

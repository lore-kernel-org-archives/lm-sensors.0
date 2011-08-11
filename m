From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Thu, 11 Aug 2011 19:36:22 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Fix applesmc temperature
Message-Id: <20110811193622.GB5885@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-2-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-2-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 10, 2011 at 06:57:09PM +0100, Matthew Garrett wrote:
> On Wed, Aug 10, 2011 at 10:41:06AM -0700, Guenter Roeck wrote:
> > On Wed, 2011-08-10 at 13:17 -0400, Matthew Garrett wrote:
> > > Yeah, my MBA returns these from TCZ3 and TH0F. Typical read value is 
> > > 0xf978. There may be some other underlying issue that's triggering this, 
> > > but returning data that's known to be bogus seems unhelpful.
> > > 
> > Sounds like that is a persistent condition, though, not a temporary one.
> > Negative values returned from temperature sensors often indicate either
> > a non-existing thermistor or a sensor fault.
> > 
> > Personally, I think it would be better to just ignore the returned
> > value. Ultimately, you'll have to add an entry into sensors.conf anyway,
> > and returning an error just because the returned value _might_ be wrong
> > does not seem to be a good idea to me.
> 
> We can pretty much guarantee that this hardware won't be running below 
> freezing in this case. Smarter userspace can see an error and then 
> ignore the sensor in the UI.

To that end, userspace can equally well read the negative value.

Bogus sensor values is an integral part of some of the machines. For
instance, on some models, remove the battery and some temperature
sensors will start to oscillate between zero and max. Some time ago, I
tried to come up with a patch which would detect this behavior, so far
without positive reports. If anything, it would make sense to filter
the list of available sensors, either dynamically (removing it from
the sysfs tree) or by clamping the value to zero or
something. Reporting an error does not seem very useful.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

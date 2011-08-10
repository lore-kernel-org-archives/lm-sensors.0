From: Matthew Garrett <mjg@redhat.com>
Date: Wed, 10 Aug 2011 17:57:09 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Fix applesmc temperature
Message-Id: <20110810175709.GB7667@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-2-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-2-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 10, 2011 at 10:41:06AM -0700, Guenter Roeck wrote:
> On Wed, 2011-08-10 at 13:17 -0400, Matthew Garrett wrote:
> > Yeah, my MBA returns these from TCZ3 and TH0F. Typical read value is 
> > 0xf978. There may be some other underlying issue that's triggering this, 
> > but returning data that's known to be bogus seems unhelpful.
> > 
> Sounds like that is a persistent condition, though, not a temporary one.
> Negative values returned from temperature sensors often indicate either
> a non-existing thermistor or a sensor fault.
> 
> Personally, I think it would be better to just ignore the returned
> value. Ultimately, you'll have to add an entry into sensors.conf anyway,
> and returning an error just because the returned value _might_ be wrong
> does not seem to be a good idea to me.

We can pretty much guarantee that this hardware won't be running below 
freezing in this case. Smarter userspace can see an error and then 
ignore the sensor in the UI.

> Either case, -EINVAL seems wrong. Maybe -EIO.

Seems reasonable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

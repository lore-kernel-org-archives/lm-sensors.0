From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Apr 2009 14:36:01 +0000
Subject: Re: [lm-sensors] Why internal sensor on atom cpu isn't yet
Message-Id: <20090428163601.3f70b7fe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1240762029.10972.15.camel@maxim-laptop>
In-Reply-To: <1240762029.10972.15.camel@maxim-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 28 Apr 2009 06:31:16 -0700, Philip Pokorny wrote:
> Why doesn't this fit the current temperature interface?  What is there in the interface that says it has to be an absolute temperature and not a relative temperature?

This isn't spelt out explicitly, but it is pretty implicit. Suddenly
reporting relative temperature margins the same way we report absolute
temperature values will only confuse the user (and ourselves.) When
sensors report "+20 degrees", how will you know whether the system is
totally overheating or if it is rather cold?

If we start reporting temperature margins, the interface must be
different from what we have today so that libsensors and other tools
relying on our sysfs interface aren't screwed up. We want sensors and
other tools to clearly label temperature margins as such.

And really I think it makes a lot of sense to report relative
temperatures, I have no objection to doing that. The absolute
temperature is one thing, but the key information is whether the system
is running within its thermal specs or not.

> Alarms, min-max, hysterisis, etc all still work the same, they are just shifted so that the max limit is zero and the typical values are less than zero.  We allow negative temperatures in the library.

Just because we support them in the library doesn't mean all
applications support them. I fixed a bug with negative temperatures in
sensord a few months ago... Anyway the problem is not with negative
values. The problem is that users must _know_ what they are seeing.

So please let's not rush here. The proper interface, both at the sysfs
and libsensors levels, should be discussed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

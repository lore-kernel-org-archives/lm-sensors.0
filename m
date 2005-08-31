From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 31 Aug 2005 11:37:46 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <QZkV92qf.1125480623.7572370.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-08-31, Mark M. Hoffman wrote:

> As I pointed out on #linux-sensors, there is what I consider to be a bug
> in the /sys/class/hwmon handling: if /sys/class/hwmon is not present,
> SPD/eeproms will be read normally by sensors(1); but if it *is* present,
> then SPD/eeproms will not be found or displayed.

It's a feature :')

> Even if we plan to get rid of SPD/eeprom reading from sensors(1) (which
> I think is sensible), the current behavior is surprising, to say the
> least.

This is true and is likely to raise an unreasonable number of support
requests.  We need to anticipate that, you are plain right.

> I'm sorry I haven't had time to work up a fix - I have a four-day
> weekend coming up during which I should have some time.  At any rate,
> IMO it's a release-stopper.

I have been thinking of it, and came to the conclusion that it was merely
a documentation issue.  I was planning to add en entry in the FAQ, a
news item on our website when we release, and a note to kernel26.html. 
Don't you think it is sufficient?  What do you suggest?  I would like
to avoid adding temporary code to libsensors if possible, as we will
ultimately drop non-hwmon support anyway.

Thanks,
--
Jean Delvare

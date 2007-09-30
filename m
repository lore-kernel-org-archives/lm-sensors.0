From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 30 Sep 2007 11:54:16 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070930135416.501e03b7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 29 Sep 2007 15:39:19 +0200, Jean Delvare wrote:
> So, from the above, it seems that what we both agree on is that a
> separate error value for I/O errors would be needed. I'll work up a
> patch implementing this.

I've committed a patch:
http://www.lm-sensors.org/changeset/4899

While testing it, I found that libsysfs will silently discard
attributes which return errors when being read. This means that an
attribute which returns an error at libsensors initialization time will
be forever missing, even if it can be successfully read again later.
This is no good. One more reason to get rid of libsysfs, I presume.

This also revealed that libsysfs reads the value from all attributes
when we do the device feature detection, even though we did not ask for
it and don't need the attribute values at all at this point. This
triggers a cache refresh at the device driver level (for most drivers
at least). No big deal for "sensors", but it's needlessly slowing down
"sensors -s". It might even have hidden driver bugs, as it means the
cache is always up-to-date when "sensors -s" is run, while drivers
should be able to cope with "sensors -s" when the cache is not yet
populated. Oh well, we really have to move away from libsysfs. I've
created a ticket in trac for that, it's scheduled for lm-sensors 3.0.1:

http://www.lm-sensors.org/ticket/2262

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

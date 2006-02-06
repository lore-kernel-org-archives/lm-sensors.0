From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Feb 2006 10:17:20 +0000
Subject: [lm-sensors] [patch 1/1] hwmon-pc87360 : avoid lock & unlock
Message-Id: <SoAVfSM1.1139221040.8836220.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43E6E432.8030408@gmail.com>
In-Reply-To: <43E6E432.8030408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jim,

On 2006-02-06, Jim Cromie wrote:
> Modifies pc87360_update_device() to avoid locking & unlocking
> when data is not actually being resampled.  Also re-indented
> the body of the function, removing the now extra tabs.

Imagine that two user-space processes read sysfs files and trigger the
update, at the same time. With the original locking model, both
processes will attempt to get the lock. One only (A) will succeed, while
the other (B) will have to wait. (A) will then test the time condition,
and update the data if needs be, then release the lock. At this point,
(B) will be granted the lock, and will get to test the time condition.
As (A) just updated the timestamp, (B) will skip the update as intended,
and release the lock immediately.

With your changes, (A) and (B) will test the time condition concurrently.
If an update is needed, they will fight for the lock. (A) will get it
and do the update, then release the lock. Then (B) will get it and do
the update again! Then release the lock. So you actually had two
consecutive updates, while the caching mecanism precisely tries to avoid
this.

So this doesn't work, sorry.

--
Jean Delvare


From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <rap741tlstq7nfd4jmt9lpkpme5hnec83r@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Mar 2005 09:54:27 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:
>> How driver wait for that?  If writer taken lock, is reader
>> blocked?
>> Not as far as I see.
>
>It is blocked. It will wait until the lock is released and can be
>acquired again. This is why forgetting to release a lock leads to a
>driver lockup.

readers don't check or take the lock?  only set_something callbacks?

>
>I will (try to) provide patches for the following drivers today: lm63,
>lm80, lm83, lm87, lm90, lm92, pc87360. As a side note, the w83l785ts
>driver is read-only so it obviously doesn'y need to be updated.

I have one more sitting here, fscher.c, waiting for feedback on 
what I post already.  Glad I didn't get to lm?? then :)

Then I go check ones didn't appear on survey list because they use 
different names.  Oh, they are off my list, they're yours? :)  

my work list list at:
http://scatter.mine.nu/lmsensors/list-driver-write-locking-check

will add others to it as I see patches appear, just to scoreboard 
progress on locking issue.

semi-related:
I need a policy call on adm1026, adm1031 as they don't comply 
with other drivers data store, saving fan_div other than 0..3 
value.  It make fan_div update needlessly complex and different 
to other drivers I've encountered so far.  The conversion of 
0..3 to 1,2,4,8 is a single '<<' operation, the reverse is more 
complex if-then-else-if-then-else... statement only needed once 
in other drivers.

Cheers,
Grant.

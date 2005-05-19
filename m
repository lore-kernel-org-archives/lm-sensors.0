From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <jdh241t0jadl9n3aju9ljfiuj3ae11n3l0@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Wed, 23 Mar 2005 10:33:05 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:

>> Thinking about the fan_div setting, it is a read/modify/write
>> (RMW) operation to a chip register, should we take action to
>> prevent another process accessing the chip on i2c during this
>> RMW action?
>
>Can you (or anyone) point out a concrete example where the lack of
>locking on write could cause a problem that locking would actually
>resolve? It's better to know what we are trying to fix before we change
>anything.

I'm thinking that there is a very small window between reading 
a register, modifying some bits and writing it back out, where 
another process also does it.  Say SMP and one CPU update fan_div1
while other update fan_div2 -- adm1026 has eight of these over 
two bytes to potentially interfere with each other.  

But if the update request event stream is serialised by sysfs 
or elsewhere on its way to the driver then there is no problem.

If the i2c bus driver rate limits write traffic to bus, then 
again there is no issue.  I simply do not know.  I ask to learn.

I've attempted to not access the chip if divisor didn't 
change, which now makes it trivial to add locking around the 
read/modify/write, if the notion is deemed worthwhile.

Defensive programming.  From what?  Perhaps nothing.

Perhaps the query would make more sense with relevant patch?

Cheers,
Grant.

From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <2h964195fcqieojom2ogqc7ls41ds36kue@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
Much happened while I sleep :)  In few weeks we'll be nine 
hours out of step when some of .au goes out of daylight saving.

On Thu, 24 Mar 2005 13:26:11 +0100 (CET), "Jean Delvare" <khali@linux-fr.org> wrote:

>> Surveyed drivers/i2c/chips/*.c containing "_write_value(" and...
                                              ^^^^^^^^^^^^^
maybe your drivers didn't use this string?

>> it87.c          no locking ??
>
>What do you mean? It has the same update_lock the other drivers have,
>used only for the big update so far. A quick look shows that it needs
>locks for at least the same reason the adm1021 does, let alone possible
>multiple functions registers.

?? was I know this is SuperIO and different issues involved -- forgot 
to expand the ?? for email

>> [0] assuming lock not required until after client init completed
>
>Assumption is correct, locking makes no sense until we create at least
>one sysfs file, and sysfs file creations happens after init (if not this
>is considered a bug and shall be fixed).

I'm not sure if sysfs file creations immediately allow access? 
But if they done as last task before exit init then no problem, 
all registers written before chip interface exposed.

>> [1] down() may be before or after: val = simple_strtol(buf, NULL, 10);
>> Is this a problem?  Can anthing can stomp 'buf'?
>
>"buf" is ours. There is no reason to hold the lock during the
>simple_strtol, so for better performance the down() should be moved
>below it.
>
>> Query: Should all drivers follow lm85 model where lock taken by
>> write accessors prior to reading data->somevalue through to
>> completion?
>
>I think so. Shame on me for not realizing before. I think I remember it
>was already discussed here before, and back then I didn't realize what
>the issue was, and possibly gave bad advice to drivers porters. Please
>forgive me.

Stuff happens -- Someone just stomped in and started asking 
questions.  That same someone has lots of time and needs a 
challenge :)

>> As far as i2c bus saturation or rate limiting goes, that is not
>> something for the chip drivers, I now think it it belongs to the
>> i2c bus driver.
>
>It doesn't. For one thing, rate limitation is chip-specific, because the
>value update time differs from chip to chip. For another, some chips
>must *not* be limited in any way, or they become useless (think I/O
>expanders). Even for chips where we have a rate limitation, it doesn't
>apply to all parts of the driver, so there is no way this can be moved
>outside of the driver.

Okay, I was thinking of i2c bus saturation from communications 
point of view (or resource contention).  It is a separate issue 
to locking.  

>> 'Somebody Else's Problem' --Douglas Adams
>
>In which book is this?
Wish I could remember, I think the same one where "flying is the 
trick of falling over and not hitting the ground"...  many years 
ago.

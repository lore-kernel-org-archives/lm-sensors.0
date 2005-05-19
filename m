From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: RFC locking and rate limit updates for i2c?
Message-Id: <gl9441l7hk509cr68hq7his14308fj8egg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
In-Reply-To: <ic4141hum54km9pokicdinq82tndrig443@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

On Wed, 23 Mar 2005 20:32:26 +0100, Jean Delvare <khali@linux-fr.org> wrote:

>> I'm thinking that there is a very small window between reading 
>> a register, modifying some bits and writing it back out, where 
>> another process also does it.  Say SMP and one CPU update fan_div1
>> while other update fan_div2 -- adm1026 has eight of these over 
>> two bytes to potentially interfere with each other.  
>
>Correct, you convinced me.
>
Surveyed drivers/i2c/chips/*.c containing "_write_value(" and...

The winner is lm85.c :o)

driver          write lock taken status [0]
--------------  ------------------------------------------------------------
adm1021.c       no, appears to not need it
adm1026.c       Yes [1]
adm1031.c       Yes [1]
asb100.c        no locking, needs it 357
ds1621.c        no, appears to not need it
fscher.c        no, appears to not need it
fscpos.c        no, appears to not need it
gl518sm.c       no, appears to not need it
gl520sm.c       no locking, needs it 371
it87.c          no locking ??
lm75.c          no, appears to not need it
lm77.c          maybe? see line 171 double write temp + hyst
lm78.c          no locking, needs it 369
lm80.c          no locking, needs it 292
lm85.c          Yes -- full locking from data-> access to completion!
lm87.c          no locking, needs it 424
sis5595.c       no locking, needs it 399
smsc47m1.c      no locking, needs it 237
via686a.c       no locking, needs it -- patched, but rest need check
w83627hf.c      no locking, needs it 697
w83781d.c       no locking, needs it 559

[0] assuming lock not required until after client init completed

[1] down() may be before or after: val = simple_strtol(buf, NULL, 10);
        Is this a problem?  Can anthing can stomp 'buf'?


Query: Should all drivers follow lm85 model where lock taken by 
write accessors prior to reading data->somevalue through to 
completion?

And eyeballing all that code is about it for me today.  
Items with line number appear to have clear evidence of need
The two marked [1] are trivial to make match lm85 model
The rest are easy enough to do, can't see it breaking anything.

As far as i2c bus saturation or rate limiting goes, that is not 
something for the chip drivers, I now think it it belongs to the 
i2c bus driver.       'Somebody Else's Problem' --Douglas Adams

Cheers,
Grant.

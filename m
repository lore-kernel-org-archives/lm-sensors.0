From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <200307151909.47852.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Dienstag, 15. Juli 2003 18:28 you wrote:
> 1* We do not support old kernels. Thus:
>
> [...]
>
> is unnecessary. Did you find such code in one of our drivers?

Like I said, I used lm_sensors-2.7.0 pcf8574.c as a template. There it is 
still included :-)

> 2* According to the datasheet, the SAA1064 has four possible I2C
> addresses, ranging from 0x38 to 0x3b. So, you will want to replace:
>
> [...]
>

Done.

> 4* Use C99 style struct initializers. The following:
>
> [...]

Again, bad template :-) Fixed. Does this have to be done in the ctl_table, 
too, cause I suppose that would look quite ugly for long tables?

I've just checked back on your current CVS. Okay my template was too old 
:-). I see the ctl_table doesn't use C99 struct initializers, and I also 
see that your SYSCTL defines went into the sources now. Is that part of the 
API change you spoke about? I've inserted them into my code now, too...
One bug is fixed: ...SYSCTL_DIGIT0 should really be ...SYSCTL_DISP (as the 
function and proc names also are "disp"). Tell me if anything needs still 
be changed, also regarding new APIs, since it's the first time I'm doing 
things in kernel space (and I'm having a good time *g*).

> Now, more important: is it working OK, at least for you? :)

Yup :-) Works very fine, here. On startup, everything lights up (maybe I 
should put "init" on, instead?), then I disable the testmode, everything 
gets dark, and I can program the digits...

Another small thing (@all *g*):
Most of your modules lack the #ifdef MODULE...#endif construct usually 
embracing init_module and cleanup_module. That prevents most of these to 
run smoothly compiled into the kernel. Is this a bug or a feature? 

Since I am using a highly compact kernel for a thin client, with LIRC, 
em8300 and even I2C compiled into the kernel, all working fine (after 
adding the missing #ifdef construct), it can't be principle-caused.

Greetings,
Sascha

-------------- next part --------------
A non-text attachment was scrubbed...
Name: saa1064.c
Type: text/x-csrc
Size: 17700 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030715/5b804f00/saa1064.bin

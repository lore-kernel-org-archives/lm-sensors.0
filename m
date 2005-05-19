From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: Clean up of i2c-elektor.c build for 2.6.11
Message-Id: <4230E038.2020601@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422E2417.7020707@aeroflex.com>
In-Reply-To: <422E2417.7020707@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Frank,
>
>  
>
>>drivers/i2c/busses/i2c-elektor.c:120: warning: comparison of distinct
>>pointer types lacks a cast
>>drivers/i2c/busses/i2c-elektor.c:127: warning: comparison of distinct
>>pointer types lacks a cast
>>drivers/i2c/busses/i2c-elektor.c:131: warning: comparison of distinct
>>pointer types lacks a cast
>>
>>I traced it down to the flags type on line 115.
>>(...)
>>--- diff ---
>>i2c-elektor.c
>>115c115
>><       long flags;
>>---
>>    
>>
>>>      unsigned long flags;
>>>      
>>>
>
>Hey, that's great. I have been wanting to get rid of these warnings for
>quite some time, and even took a look at some point, but couldn't
>figure out what was wrong. Turns out to be very simple to fix, so I'm
>kind of ashamed that I didn't find the reason and fix back then ;)
>
>When submitting patches, please make them "unified" (diff -u). Also,
>please include complete paths so that patches can be applied with patch
>-p1. The command would be something like:
>  diff -u linux-2.6.11/drivers/i2c/busses/i2c-elektor.c.orig \
>          linux-2.6.11/drivers/i2c/busses/i2c-elektor.c > ~/some-file.diff
>
>Please post the patch again in this format, with a short description of
>what the patch does and the standard "Signed-Off-By" line, so that
>Greg can accept it in its bk-i2c tree.
>
>Thanks,
>--
>Jean Delvare
>
>  
>

Greg,

Please find attached the diff for i2c-elektor.c discussed above.

Thanks
Frank

This patch changes the flags variable type from long to unsigned long in 
one function. This removes a couple of warnings from the compile 
messages for elektor i2c bus driver.

Signed-Off-By Frank Beesley



-------------- next part --------------
A non-text attachment was scrubbed...
Name: elek.diff
Type: text/x-patch
Size: 493 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050310/9c37f3d0/elek.bin

From: dsmoot@orbitalnetwork.com (David Smoot)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: update to ticket 1951, I think I found a compatibility issue
Message-Id: <01336f4802cf0eec1d009c72dc827823@orbitalnetwork.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10aa26513908ee38e81301114cb87dc9@orbitalnetwork.com>
In-Reply-To: <10aa26513908ee38e81301114cb87dc9@orbitalnetwork.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's your package and I understand not wanting to mess with an obsolete 
package but this particular issue makes the whole package unusable for 
any kernel 2.4.10.  If I were you I would at least put a note in the 
installation that warns about this.


On Apr 17, 2005, at 4:07 AM, Jean Delvare wrote:

> Hi David,
>
>> I'm pretty new at Linux so I could be wrong but i think I found a
>> minor  bug.  First let me say because of the deployed software we have
>> in  place, I have to make your package work with a redhat 7.1
>> distribution  (kernel 2.4.7-10)
>>
>> I have been unable to get lm sensors to build on my clean redhat 7.1
>> box (kernel 2.4.7-10).  The specific error I get is:
>>
>> gcc  -DMODVERSIONS -include
>> /lib/modules/2.4.7-10/build/include/linux/modversions.h -D__KERNEL__
>> -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include
>> -I/usr/local/include -I/lib/modules/2.4.7-10/build/include   -O2   -c
>> kernel/busses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
>> kernel/busses/i2c-amd8111.c: In function `amd8111_access':
>> kernel/busses/i2c-amd8111.c:272: parse error before `u8'
>> kernel/busses/i2c-amd8111.c:281: parse error before `u8'
>> kernel/busses/i2c-amd8111.c:300: parse error before `u8'
>> kernel/busses/i2c-amd8111.c:360: parse error before `u8'
>> kernel/busses/i2c-amd8111.c: At top level:
>> kernel/busses/i2c-amd8111.c:500: initializer element is not constant
>> kernel/busses/i2c-amd8111.c:500: (near initialization for
>> `amd8111_driver.remove')
>> kernel/busses/i2c-amd8111.c:501: initializer element is not constant
>> kernel/busses/i2c-amd8111.c:501: (near initialization for
>> `amd8111_driver')
>> make: *** [kernel/busses/i2c-amd8111.o] Error 1
>>
>> When I view the code for i2c-amd8111.c line 272 I noticed the min_t
>> function.  According to my googling, min_t was not defined until
>> kernel  2.4.10.  see:
>> http://www.linuxathome.net/archive/arc8-2001.html and
>> http://lists.osdl.org/pipermail/kernel-janitors/2004-April/000887.html
>>
>> I grep'd the lm_sensors-2.7.0 code and that was the only source file
>> that used min_t.  So I edited the Module.mk in kernel/busses and
>> commented out the target instructions related to i2c-amd8111.c.  I
>> tried "make all" again as root and it completed the build process.
>>
>> So it appears to me that at least that module is not compatible with
>> any kernel pre 2.4.10.
>>
>> I consider my issue solved if you want to close the ticket.  You
>> might want to put a disclaimer somewhere about this.
>
> I updated the ticket with your own comment, and closed it. It's always
> great when users support themselves ;) Thanks a lot for letting us 
> know.
>
> It's absolutely possible that lm_sensors 2.7.0 was advertised to work 
> on
> kernels where it didn't actually. That being said, Linux 2.4.7 is a bit
> old, and so is lm_sensors 2.7.0, so that's just the way it is and we're
> not going to fix anything there and release a modified version. I guess
> you can understand that. We already have a hard time keeping up with 
> the
> more recent kernels...
>
> Hopefully, if someone hits the same problem, he/she will find your
> ticket or this mailing-list thread with the solution.
>
>> By the way, thank you for such a wonderful project.  Even though I
>> have  struggled with this for several days, it beats the heck out of
>> coding  my own hardware monitoring package from scratch.
>
> Thanks :')
>
> -- 
> Jean Delvare
>

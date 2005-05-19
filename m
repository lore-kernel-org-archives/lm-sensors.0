From: palsedgj@colorado.net (John Palsedge)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: make install problem with i2c package
Message-Id: <4054AF01.2040900@colorado.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4054812F.50803@colorado.net>
In-Reply-To: <4054812F.50803@colorado.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for your instant response.  You sure don't get that from 
Microsquash!

I tried what you suggested: I copied

kernel-2.4.7-athlon.config

into /usr/src/linux-2.4/.config     as I have an AMD athlon processor. I then did make clean on both the i2c and lm makefiles.  A lot of stuff was removed.  And then make install on i2c.  

I got the same "Error 1" message but did not get the message

grep: /lib/modules/2.4.7-10/build/.config: No such file or directory    

Don't spoil your Sunday on it.  I am not an expert kernel builder so it is possible that there is something I should know that I don't.  
    



Mark M. Hoffman wrote:

>Hi John:
>
>* John Palsedge <palsedgj@colorado.net> [2004-03-14 08:58:39 -0700]:
>
>>System: Red Hat 7.2,  2.4.7-10 kernel
>>download: i2c-2.7.0.tar.gz
>>
>>Makefile: default (include files -> /usr/local/include)
>>
>>compile seemed to go OK.
>>
>>make install (ran as root) failed with messages:
>>
>>grep: /lib/modules/2.4.7-10/build/.config: No such file or directory     
>>    (true)
>>Note: /lib/modules/2.4.7-10/build ->  ../../../usr/src/linux-2.4.7-10/, 
>>contents of which are
>>
>>abi/      CREDITS         include/  lib/         net/            scripts/
>>arch/     Documentation/  init/     MAINTAINERS  README
>>configs/  drivers/        ipc/      Makefile     REPORTING-BUGS
>>COPYING   fs/             kernel/   mm/          Rules.make
>>
>>contents of configs is
>>
>>kernel-2.4.7-athlon.config      kernel-2.4.7-i586-smp.config
>>kernel-2.4.7-athlon-smp.config  kernel-2.4.7-i686.config
>>kernel-2.4.7-i386-BOOT.config   kernel-2.4.7-i686-debug.config
>>kernel-2.4.7-i386.config        kernel-2.4.7-i686-enterprise.config
>>kernel-2.4.7-i386-smp.con
>>
>
><snip>
>
>Pick one of these, as appropriate to your system, and copy it to
>/usr/src/linux-2.4/.config
>
>Then "make clean" in both i2c and lm_sensors2.  Now the build and
>install should proceed ok.
>
>Regards,
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040314/179244f3/attachment.html

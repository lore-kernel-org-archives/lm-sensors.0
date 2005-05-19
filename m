From: sharman@technologist.com (Darren)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Dependency problem during compile
Message-Id: <1076749863.803.13.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073609543.32040.73.camel@localhost>
In-Reply-To: <1073609543.32040.73.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

I spent some more time on the issues, but still didn't get beyond the
compile problems I was having. n.b. basically the compile finishes
with..
"
<snip>
cc -M -MG -I. -Ikernel/include -I  -fpic -Wall -O2  lib/proc.c | \
        sed -e 's@^\(.*\)\.o:@lib/proc.ld lib/proc.lo: Makefile
'`dirname lib/proc.ld`/Module.mk' @' > lib/proc.ld
cc -M -MG -I. -Ikernel/include -I  -fpic -Wall -O2  lib/chips.c | \
        sed -e 's@^\(.*\)\.o:@lib/chips.ld lib/chips.lo: Makefile
'`dirname lib/chips.ld`/Module.mk' @' > lib/chips.ld
make: *** No rule to make target `linux/modsetver.h', needed by
`kernel/chips/vt1211.d'.  Stop.
"

This is true for 2.8.2 and 2.8.4 versions of the system.

Do you have any thoughts about what is wrong?

Was I correct in thinking that I can compile against a different kernel
than the one running on the compile system? The target system is an EPIA
box.

Thanks for coming back to me on this issue, its appreciated.

Regards,

Darren

On Fri, 2004-02-13 at 20:21, Jean Delvare wrote:
> Hi Darren,
> 
> Could you finally figure out what was going wrong with lm_sensors'
> compilation? I was kind of short of time at that moment so I did not
> answer, sorry.
> 
> Let me know how you solved the problem if you did.
> 
> Thanks.
-- 
Darren <sharman@technologist.com>

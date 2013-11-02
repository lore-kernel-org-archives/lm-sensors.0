From: David Anderson <davea42@gmail.com>
Date: Sat, 02 Nov 2013 17:16:28 +0000
Subject: Re: [lm-sensors] w83795.c no longer compiles
Message-Id: <5275336C.2060107@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5273CD89.6030803@gmail.com>
In-Reply-To: <5273CD89.6030803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/01/2013 02:09 PM, Guenter Roeck wrote:
> On Fri, Nov 01, 2013 at 08:49:29AM -0700, David Anderson wrote:
>> Just installed the new Ubuntu 13.10.   Kernel 3.11.0-12 #19.
>> I get an error building w83795.c (building a module to read
>> my  w83795adg temp sensor) for this kernel.
> SENSORS_LIMIT no longer exists; replace it with clamp_val.
>
> Is the driver in the upstream kernel different to the version above ?
>

Yes.  Different, I now see.

I picked up
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
and the upstream w83795.c had changes.  I built a module
on the target machine using
the upstream w83795.c  ---- it compiles with no warnings and
the new module is working fine in my kernel.

Honestly, it would not have occurred to me  look for the latest
or try building latest w83795.c !

Many thanks for your help.
David Anderson







_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

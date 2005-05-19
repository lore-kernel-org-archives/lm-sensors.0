From: clepple@ghz.cc (Charles Lepple)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: porting libsensors to the 2.6 kernel's /sys interface
Message-Id: <34874EA0-C237-11D7-BB43-003065DC6B50@ghz.cc>
List-Id: <lm-sensors.vger.kernel.org>
References: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
In-Reply-To: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday, July 29, 2003, at 10:01  PM, Greg KH wrote:

> On Mon, Jul 28, 2003 at 11:36:10PM -0400, Charles Lepple wrote:
>> I took a look at porting libsensors to work with the new /sys 
>> interface
>> to the sensor readings, and I have a few questions.
>
> I think an almost entirely new api and rewrite will be necessary, not
> merely a port.  But that's just my opinion after studying the current
> code, not as one who is doing any actual work on it :)

That's somewhat troubling :-)

I was thinking of something more along the lines of a shim so that 
people wouldn't have to rewrite all of their apps just because they 
upgraded the kernel...

>> So is there any need to include the kernel headers when compiling 
>> other
>> parts of lm_sensors? In particular, I ran into trouble with the 2.6
>> version of linux/sysctl.h, and disabling $(LINUX_HEADERS) in the
>> makefile (by setting it to '.') picked up /usr/include/linux/sysctl.h,
>> which resulted in a much happier compiler.
>
> NEVER use kernel header files from userspace!!!

Honest, the Makefile did it, not me! It broke hardcore against 2.6 
(__user macros and all), so that's why I was trying to figure out what 
was going on there.

> Use the glibc sanitized ones that your glibc is built against.  If not,
> bad things will happen.

OK, so basically what that means is that LINUX_HEADERS needs to come 
out of ALL_CPPFLAGS (or some similar kernel/userspace CPPFLAGS split 
has to happen).

>> so for short-lived polling programs, it might make sense to check for
>> /proc or /sys before attempting the system call.
>
> sysctl is not needed for sensor stuff in 2.6.

right, I was thinking of a one-size-fits-all library. Basically, the 
code would check for /sys, fall back to /proc (for 2.4 kernels) and try 
sysctl if neither of those are available. In an embedded app, a #define 
could cut that down to the sysctl interface alone.

> Good luck,

hmm, given the amount of time that I have available to work on this, I 
may just slink back into a corner and work on my /sys-to-rrdtool 
script. I don't claim to have enough understanding of the advantages 
and disadvantages of the current library to warrant writing a new API. 
(I figured I might have enough time to adapt the current code to read 
the individual /sys files as opposed to the value-min-max type files in 
/proc.)

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/

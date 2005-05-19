From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: porting libsensors to the 2.6 kernel's /sys interface
Message-Id: <20030730020148.GA5409@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
In-Reply-To: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 28, 2003 at 11:36:10PM -0400, Charles Lepple wrote:
> I took a look at porting libsensors to work with the new /sys interface 
> to the sensor readings, and I have a few questions.

I think an almost entirely new api and rewrite will be necessary, not
merely a port.  But that's just my opinion after studying the current
code, not as one who is doing any actual work on it :)

> First, let me explain the scope of this attempt: I already have the 
> 2.6.0test2 i2c and sensor kernel drivers working, so I just want to 
> make the userspace tools (libsensors, basically) work with the new 
> paths. That means that I'm setting COMPILE_KERNEL to 0 in the 
> lm_sensors makefile. Compiling the lm_sensors kernel/ directory is 
> going to be different than in 2.4, I'm afraid-- the out-of-kernel build 
> process changed for the ThinkPad driver modules, and I think it'll be 
> different here too.
> 
> So is there any need to include the kernel headers when compiling other 
> parts of lm_sensors? In particular, I ran into trouble with the 2.6 
> version of linux/sysctl.h, and disabling $(LINUX_HEADERS) in the 
> makefile (by setting it to '.') picked up /usr/include/linux/sysctl.h, 
> which resulted in a much happier compiler.

NEVER use kernel header files from userspace!!!
Use the glibc sanitized ones that your glibc is built against.  If not,
bad things will happen.

> Also, I noticed the use of the numerical sysctl interface. Is that 
> required for some 2.4 kernels? I would imagine that most people who are 
> running 2.4 also have /proc mounted, so it might make sense to combine 
> some code and just check for /proc or /sys files. In 2.6, using 
> sysctl() yields this in the logs at every invocation of the program:
> 
>   sensors: numerical sysctl 7 2 1 is obsolete.
> 
> so for short-lived polling programs, it might make sense to check for 
> /proc or /sys before attempting the system call.

sysctl is not needed for sensor stuff in 2.6.

Good luck,

greg k-h

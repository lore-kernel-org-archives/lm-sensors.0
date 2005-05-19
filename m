From: clepple@ghz.cc (Charles Lepple)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: porting libsensors to the 2.6 kernel's /sys interface
Message-Id: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I took a look at porting libsensors to work with the new /sys interface 
to the sensor readings, and I have a few questions.

First, let me explain the scope of this attempt: I already have the 
2.6.0test2 i2c and sensor kernel drivers working, so I just want to 
make the userspace tools (libsensors, basically) work with the new 
paths. That means that I'm setting COMPILE_KERNEL to 0 in the 
lm_sensors makefile. Compiling the lm_sensors kernel/ directory is 
going to be different than in 2.4, I'm afraid-- the out-of-kernel build 
process changed for the ThinkPad driver modules, and I think it'll be 
different here too.

So is there any need to include the kernel headers when compiling other 
parts of lm_sensors? In particular, I ran into trouble with the 2.6 
version of linux/sysctl.h, and disabling $(LINUX_HEADERS) in the 
makefile (by setting it to '.') picked up /usr/include/linux/sysctl.h, 
which resulted in a much happier compiler.

Also, I noticed the use of the numerical sysctl interface. Is that 
required for some 2.4 kernels? I would imagine that most people who are 
running 2.4 also have /proc mounted, so it might make sense to combine 
some code and just check for /proc or /sys files. In 2.6, using 
sysctl() yields this in the logs at every invocation of the program:

   sensors: numerical sysctl 7 2 1 is obsolete.

so for short-lived polling programs, it might make sense to check for 
/proc or /sys before attempting the system call.

At the moment, I'm dabbling in my own CVS repository. After I get 
things working, this might be a good candidate for a branch in the 
project CVS (or SVN, or BK... wasn't sure what the most up-to-date one 
was, from the web page).

Thoughts? Any other considerations?

later,

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/

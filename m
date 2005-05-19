From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: porting libsensors to the 2.6 kernel's /sys interface
Message-Id: <3F2DA779.6000008@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
In-Reply-To: <CBF7F1A2-C175-11D7-BB43-003065DC6B50@ghz.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think you are the first who has actually said he is working on it.

If you plan do get far enough to contribute something,
we do not want to branch CVS.

First choice would be a single libsensors that works with both kernels.
Second choice would be to copy the lib/ directory (or parts of it) to
a new directory (lib2?) and do the mods there.

Greg is correct that we shouldn't be including kernel headers for the userspace stuff.

Charles Lepple wrote:
> I took a look at porting libsensors to work with the new /sys interface 
> to the sensor readings, and I have a few questions.
> 
> First, let me explain the scope of this attempt: I already have the 
> 2.6.0test2 i2c and sensor kernel drivers working, so I just want to make 
> the userspace tools (libsensors, basically) work with the new paths. 
> That means that I'm setting COMPILE_KERNEL to 0 in the lm_sensors 
> makefile. Compiling the lm_sensors kernel/ directory is going to be 
> different than in 2.4, I'm afraid-- the out-of-kernel build process 
> changed for the ThinkPad driver modules, and I think it'll be different 
> here too.
> 
> So is there any need to include the kernel headers when compiling other 
> parts of lm_sensors? In particular, I ran into trouble with the 2.6 
> version of linux/sysctl.h, and disabling $(LINUX_HEADERS) in the 
> makefile (by setting it to '.') picked up /usr/include/linux/sysctl.h, 
> which resulted in a much happier compiler.
> 
> Also, I noticed the use of the numerical sysctl interface. Is that 
> required for some 2.4 kernels? I would imagine that most people who are 
> running 2.4 also have /proc mounted, so it might make sense to combine 
> some code and just check for /proc or /sys files. In 2.6, using sysctl() 
> yields this in the logs at every invocation of the program:
> 
>   sensors: numerical sysctl 7 2 1 is obsolete.
> 
> so for short-lived polling programs, it might make sense to check for 
> /proc or /sys before attempting the system call.
> 
> At the moment, I'm dabbling in my own CVS repository. After I get things 
> working, this might be a good candidate for a branch in the project CVS 
> (or SVN, or BK... wasn't sure what the most up-to-date one was, from the 
> web page).
> 
> Thoughts? Any other considerations?
> 
> later,
> 

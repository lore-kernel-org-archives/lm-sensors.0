From: huivzhopu@hotmail.com (Michael Alladin)
Date: Fri, 17 Mar 2006 05:53:42 +0000
Subject: [lm-sensors] couple of issues - MSI AMD64 motherboard and sysfs
Message-Id: <BAY12-F3EE11C41D520A1A1EB1B8B5E40@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone

I have MSI K8NGM2-FID motherboard (AMD64). I am not exactly sure which 
module driver needs to be loaded -- w83627ehf   seems to work but I'm not 
sure if that's the right one. I do get some output from sensors, which makes 
some sense:

bash-2.05b$ sensors
w83627ehf-isa-0a10
Adapter: ISA adapter
Case Fan: 1350 RPM  (min =    0 RPM, div = 8)
CPU Fan:  3245 RPM  (min =  922 RPM, div = 8)
fan3:        0 RPM  (min = 10546 RPM, div = 128)
fan4:        0 RPM  (min = 10546 RPM, div = 128)
Sys Temp:    +35 C  (high =   -87 C, hyst =    -8 C)
CPU Temp:  +39.0 C  (high = +80.0 C, hyst = +75.0 C)
unknown:   +41.5 C  (high = +80.0 C, hyst = +75.0 C)


Now, what puzzles me, is the last temp. reading -- i cannot determine what 
the heck it is. I tried putting a fan directly over Northbridge chip, then 
over Southbridge, and this "unknown" temp. didn't change at all.  In fact, I 
don't think it changes it all, which makes me think it's bogus (or the 
driver is  not correct for my motherboard).

The second issue i have is that sysfs is not writable (2.6.16.6 kernel). I 
tried to specify rw parameter in /etc/fstab but that didn't help. Google is 
of no help either.

bash-2.05b$ su
Password:
bash-2.05b# sensors -s
bash: sensors: command not found
bash-2.05b# /usr/local/bin/sensors -s
w83627ehf-isa-0a10: Can't access procfs/sysfs file for writing;
Run as root?
bash-2.05b#

So, my questions  are, did anyone get this particular M/B working with 
lm_sensors properly, what module and config they used; and what to do with 
sysfs write error?

thanks a bunch!

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/



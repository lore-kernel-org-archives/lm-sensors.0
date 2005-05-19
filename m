From: seth@integratedsolutions.org (Seth Bardash)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: I2c and lm sensors 2.7.0 - sensors segmentation fault.
Message-Id: <000c01c2fbd9$840f5eb0$0300a8c0@dmp1800>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just tried to install i2c 2.7.0 and lm sensors 2.7.0 on a dual
AMD MP2600+ machine running RH 8.0 with updates. Drivers load
but when sensors command is run I get a segmentation fault.

This system: 
Tyan S2466N-4M, 
3.5 GB DRAM, 
80 GB HD, 
nVidia GeForce 4 MX440 AGP Card with 
  nVidia driver version NVIDIA-Linux-x86-1.0-4349
CDROM and Floppy
Redhat 8.0 with all updates including 2.4.18-27.8.0smp kernel

Interesting that I then removed 2.7.0 and installed 2.6.5 (both
i2c and lm) this worked fine. If it would help I can send the
sensors.conf and the modules.conf files and anything else that
may be helpful. 

I do not need an immediate remedy as 2.6.5 works but thought I
should tell someone.

If we can help testing this we are willing. We have a server
that can be updated to specific kernel and then have i2c and lm
sensors installed that is almost identical to the above system.

Thanks

Seth Bardash

Integrated Solutions and Systems
1510 North Gate Road
Colorado Springs, CO 80921

http://www.integratedsolutions.org

Phone:   719-495-5866
Fax:     719-495-5870

Supplier of AMD, Intel and SPARC Servers and Systems
running Windows, Linux, Solaris and VxWorks.

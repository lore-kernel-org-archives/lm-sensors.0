From: andrew.r.cress@intel.com (Cress, Andrew R)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Support for Intel BMC chipsets via IPMI
Message-Id: <A5974D8E5F98D511BB910002A50A66470580D387@hdsmsx103.hd.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Folks,

I like the way your project ties together lots of types of sensors.  
I have a project that uses IPMI to do various things, including get 
sensor data and decode the readings.  It is compatible with either
the /dev/ipmikcs (valinux) or /dev/imb (Intel) interfaces, and has 
been validated with Corey's IPMI driver.  
This code works with Intel BMC chipsets.  
See  http://panicsel.sourceforge.net  (sensors.c)

I'm currently working on conforming the interface of these utilities
to the saforum.org's Hardware Platform Interface.  So, I'd be interested 
in what interface you have now, and if you are planning to move to SA HPI or
not.

You had "Intel Xeon" chips listed as not yet supported, but these would be
supported by the IPMI interface to Intel BMC chipsets which control the
sensors for Xeon processor systems.  Perhaps my code will help fill that
gap, 
if I understand what you meant correctly?

Andy

Andy Cress                        803-461-6106  fax:803-461-6292
Senior Software Engineer    andrew.r.cress@intel.com
Intel Corporation, Columbia Design Center, CBA2
250 Berryhill Rd., Suite 100, Columbia, SC 29210-6470
BTW, I speak for myself, not for Intel Corp.
"Do not merely look out for your own personal interests, but also for the
interests of others." Phil 2:4

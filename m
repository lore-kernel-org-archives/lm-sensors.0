From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: lm_sensors2/kernel/chips lm93.c Module.mk
Message-Id: <20040805034923.GB4844@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

> Update of /home/cvs/lm_sensors2/kernel/chips
> In directory mordac.netroedge.com:/tmp/cvs-serv32026/kernel/chips
> 
> Modified Files:
> 	Module.mk 
> Added Files:
> 	lm93.c 
> Log Message:
> (mmh) first draft at a driver for LM93

There are several parts of this driver that are unique among the sensors
drivers.  Any comments are welcome... especially w.r.t. these topics:

1. Use of SMBus block data read transactions, where possible.  This can
	be overridden by a module param.

2. Two different modes for in7/in8 limits when these channels are wired
	to vccp1/vccp2 respectively.  I chose to force the user to one
	mode or the other, again by module param.

3. Absurd complexity of inX calculations in general, due to a plethora
	of different range limits and (chip internal) scaling factors.

4. More new and unique /proc files...

Of the TODOs in the file, the one that concerns me most is what to do
about the alarms: there are more than 32 bits worth of them...  I've
chatted w/ Khali briefly about it but didn't get very far.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

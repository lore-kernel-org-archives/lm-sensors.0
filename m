From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Fwd: bmcsensors FRU support
Message-Id: <416DD5F2.8070509@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sorry for the delay in responding.

The FRU (field replaceable unit) SDR record is there for reference and inventory,
AFAIK. What I print out is pretty much what's in the SDR.
If there is more you can do with it (send commands to the FRU, get more info),
I'm not sure. The spec isn't very clear to me, and my system doesn't have
any FRU SDR's.
The spec you want to look at is IPMI v1.5.
If you come up with any enhancements please send them to our mailing list.
mds 


> Subject:
> bmcsensors FRU support
> From:
> Ashley GC <csuwf@dcs.warwick.ac.uk>
> Date:
> Thu, 19 Aug 2004 16:05:21 +0100 (BST)
> To:
> mdsxyz123@yahoo.com
> 
> 
> Hello,
> 
> I am using your bmcsensors kernel module to monitor some voltates, 
> fan speeds and temperatures, but syslog also has some messages[1] 
> about power supply FRUs. Is there a plan to support these in 
> the near future? If not, can you point me to a data sheet so that I 
> can write my own extensions to your module?
> 
> Thanks,
> Ashley GC.
> 
> 1. http://www.dcs.warwick.ac.uk/~csuwf/bmcsensors-syslog-messages.html 
>    (bold lines)
> 

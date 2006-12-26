From: twb0@lymenet.org (Thomas Brown)
Date: Tue, 26 Dec 2006 22:30:04 +0000
Subject: [lm-sensors] HP Compaq ProLiant DL380 detect failure
Message-Id: <4591A26C.7040700@lymenet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4568C502.6070305@lymenet.org>
In-Reply-To: <4568C502.6070305@lymenet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks all--if we can get this working there is a large community of HP 
ProLiant server users who will benefit.

Upon tracing the "hplog" process behavior, it seems to read the data is 
by using message queues attached to the Proliant System Health Monitor 
(hpasmd) process which, in turn, may also rely on data from the HP 
Lights-Out Drivers and Agents (hprsm) daemon.

There are two routes that might be taken here:

1.  Reverse-engineer the hpasmd process and read values directly from 
the HP/Compaq hardware.
   or
2.  Write a shim to work in concert with an existing hpasmd process and 
feed data back using existing drivers (i.e. /dev/cpqhealth/proc, 
/dev/cpqhealth/cevt, etc.)

-Tom


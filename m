From: Bruce.Shaw@gov.ab.ca (Bruce Shaw)
Date: Tue, 08 Aug 2006 15:36:12 +0000
Subject: [lm-sensors] New lmSensors code for net-snmp
Message-Id: <942CA19082ED6F46AE1CD8C4A0A9A66D08AE69BF@excedm2gwba.env.gov.ab.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

net-snmp (www.net-snmp.org) uses code to access sensor information from Sun
workstations and delivers it in the format of the LM-SENSORS-MIB.  I have
recently posted changes to the code that should allow it to run on all
ULTRASPARC Sun workstations that deliver sensor information.  The links are
below

http://net-snmp.cvs.sourceforge.net/*checkout*/net-snmp/net-snmp/agent/mibgr
oup/ucd-snmp/lmSensors.h?revision=5.2
http://net-snmp.cvs.sourceforge.net/*checkout*/net-snmp/net-snmp/agent/mibgr
oup/ucd-snmp/lmSensors.c?revision=5.16

I would like as many people as possible to try this before it is widely
distributed.

-- 

This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal and or privileged
information. Please contact us immediately if you are not the intended
recipient of this communication, and do not copy, distribute, or take action
relying on it. Any communication received in error, or subsequent reply,
should be deleted or destroyed.



From: Bruce.Shaw@gov.ab.ca (Bruce Shaw)
Date: Mon, 06 Mar 2006 19:19:26 +0000
Subject: [lm-sensors] sensors + snmpd?
Message-Id: <942CA19082ED6F46AE1CD8C4A0A9A66D08AE6391@excedm2gwba.env.gov.ab.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <440AA77C.5080505@donehue.net>
In-Reply-To: <440AA77C.5080505@donehue.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>I'm running debian sarge, with a 2.6 kernel.  I have sensors working 
>correctly (with the output I require).  Can anyone point me to some 
>documentation on how to get sensors working with snmpd? (netsnmp).

Depending upon what sensors you are using, you may be working beyond snmpd's
capabilities.

Try:

snmpwalk -v 2c -c [community string] -m ALL localhost ucd-snmp/lmSensors

and see what that gives you.

AFAIK the net-snmp code only recognizes the LM75 chip but YYMV.

Contributions are certainly welcome.

J. W. Bruce Shaw
Core Developer
Net-snmp project
http://www.net-snmp.org 

This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal and or privileged
information. Please contact us immediately if you are not the intended
recipient of this communication, and do not copy, distribute, or take action
relying on it. Any communication received in error, or subsequent reply,
should be deleted or destroyed.



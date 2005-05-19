From: j.snyers@cherokee.be (Jehan Snyers d'Attenhoven)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: Error in SMBUs protocol document
Message-Id: <HIEHIBLPFMGOIENAGCDKKEJDCCAA.j.snyers@cherokee.be>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

I spotted an important (typo) error in the SMBus protocol document located
at:
http://www2.lm-sensors.nu/~lm78/cvs/i2c/doc/smbus-protocol

In the SMBus block process call section:

SMBus Block Process Call
============

SMBus Block Process Call was introduced in Revision 2.0 of the
specification.

This command selects a device register (through the Comm byte), sends
1 to 31 bytes of data to it, and reads 1 to 31 bytes of data in return.

S Addr Wr [A] Comm [A] Count [A] Data [A] ...
                             S Addr Rd [A] [Count] A [Data] ... A P


It should be a NACK ending the communication, NOT an ack. I checked with the
SMBus specs v2.0, p33 fig 5.21.
S Addr Wr [A] Comm [A] Count [A] Data [A] ...
                             S Addr Rd [A] [Count] A [Data] ... NA P

This error can lead some to error, like it did for me 

Thank you and best regards.
--
Jehan Snyers d'Attenhoven
Project Leader
Cherokee Europe
http://www.cherokee.be/ <http://www.cherokee.be/>
Phone: +32.10.438.394
Mobile: +32.478.457.490

*** This message is printed on 100% recyclable electrons. ***

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030507/b3301d0c/attachment.html

From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 03 Jan 2006 07:52:47 +0000
Subject: [lm-sensors] scx200_acb: unexpected ACBCTL2 readback
Message-Id: <1136274767.4455.22.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

On the voyage-linux mailing list there recently has been a report about
a problem related to scx200_acb in 2.6.x kernels. The original report is
at [1], a short but more detailed analysis of the problem is at [2]. 

The problem seems to be that loading scx200_acb fails during the probing
phase, but loading and using LM77 after that still works fine. Quoting
[2]:

== cut =Same here with a non-voyage 2.6.11 kernel. I enabled debugging and added
a bit more info into the relevant message and I get:

i2c /dev entries driver
scx200_acb: ACBCTL2 readback failed, got 0xff
  : probe failed

The driver write 0x70 to ACBCTL2 and expects to read 0x70 back, but it
gets 0xff instead. Looked into the manual briefly, but seems too
complicated to figure out quickly. As you mention, lm77 works fine
thereafter. Weird...
== cut =
Comments?

Bye, Mike

[1]
http://list.voyage.hk/pipermail/voyage-linux/2005-December/000548.html
[2]
http://list.voyage.hk/pipermail/voyage-linux/2006-January/000565.html



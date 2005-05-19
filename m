From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: SmBus driver for ATI chip 1002:4353
Message-Id: <200411301252.28267.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a laptop (a Samsumg P28) which has lots of ATI chips in it.  One of 
them (according to lspci) is an SmBus controller, and it has a PCI id of
1002:4353.  Looking at the lmsensors web site there are no bus drivers
for any ATI chips.  This seems to be one of the functions in the Ati 
9000 IGP chip, which is also the video driver.  It is marked as being
the 9100 IGP chip in the linux PCI repository, but I guess they use the
same silicon in both chips.

I could not find any documentation on the chip (technical stuff that is,
plenty of marketting material), but I am not quite sure where ATI
publish such things.

Is anyone working on such a chip?

David

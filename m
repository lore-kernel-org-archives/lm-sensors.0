From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: General questions
Message-Id: <20040118125025.3102d486.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

A few questions if you don't mind:

1* Where again can I see the patches for the 2.6 i2c subsystem as you
apply them? I thought it was somewhere in http://linuxusb.bkbits.net/ but
I can't see anything these days, although you say you have applied a
dozen patches.

2* Wouldn't it be time to send what you have to Linus? I count no less
than 18 patches (and I think I have one or two more for you), would be
great if at least some of them could be in 2.6.2-pre1.

3* Is there a chance that the i2c subsystem could be moved one level
down in the configure tree? I wonder why we live in "Character Devices".
The i2c subsystem is big enough to have its own subdirectory, so I would
expect it to appear in "Device Drivers" directly.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

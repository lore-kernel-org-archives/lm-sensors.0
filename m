From: red-lynx@nm.ru (Roman Morozov)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Need help with SMBus access
Message-Id: <88104910359.20020617214333@nm.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


   Dear colleagues!

   I have to write some hardware monitoring and controlling software
   (it's currently for Win32 - ops. =)), exactly air- or watercooling
   thermoelectric system for CPU cooling.

   It seems, best way to do it is to monitor CPU temperature and on
   some threshold value use fan controlling circuit to turn it on/off.

   I've done ISA-bus reading, (I've had ITE it8705f on my Gigabyte
   GA-7VTXE+), it's pretty easy. But I have brains (or whatever I had
   inside =)) melted with SMB access. Can you give me some hints about
   how should I start? I have some MBs with Via686a.

   Thank you anyway!
-- 
Best regards, Roman                          mailto:red-lynx@nm.ru
Moscow Inst. of Electronic Engineering


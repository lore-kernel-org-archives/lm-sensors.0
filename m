From: Timo.Bolse@SerNet.DE (Timo.Bolse@SerNet.DE)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: bug report?!
Message-Id: <E1Bt0wR-0002TF-00@intern.SerNet.DE>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear LM-Sensors Team,

I tried to compile i2c and lm_sensors on this machine: 

Linux dhcp230 2.4.21-99-athlon #1 Wed Sep 24 13:34:32 UTC 2003 i686 athlon i386
 GNU/Linux).
gcc version 3.3.1 (SuSE Linux)

While compilation i get on both i2c and lm_sensors the following error:

kernel/i2c-pport.c:154: error: initializer element is not constant
kernel/i2c-pport.c:154: error: (near initialization for `bit_pport_data.timeout'

Not only for i2c-pport.c. I spent some time covering this bug. I found out that
you take the HZ Value out of asm/param.h for the timeouts in many of your 
modules. For me i switch to a hardcoded value so that the element is constant.
I took the value defined for userspace in asm/param.h. (On my system 100) and
everything compiled fine. I'am not a very good c programmer so i don't know how
to cover this i think you need this timeout HZ definition because param.h makes
a difference between kernelmode and userspace.

The other problem i spotted is that your tar.gz archive of i2c-2.8.7 is not a
gzip archive.

dhcp230:~ # file i2c-2.8.7.tar.gz
i2c-2.8.7.tar.gz: POSIX tar archive

A not that much confidant user could be very confused if he is downloading a
tar.gz from you website which is a tar.

Regards,
Timo Bolse

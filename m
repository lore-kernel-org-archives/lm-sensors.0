From: "189 Lytkin Anton (PROG)" <lytkin@papillon.ru>
Date: Mon, 30 Jan 2012 02:22:25 +0000
Subject: [lm-sensors] SMBus and i801
Message-Id: <4F25FEE1.1010201@papillon.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I know some of "lm-sensors" developers wrote module for i2c-i801. I hope 
you can advice me what to do: I faced with incompatibility for some 
devices as they are using 16bit reg address, but smbus specs assumes 
only 8bit command. Is there any workarounds?
Device is simple cmos sensor - mt9j003.
thanks.

-- 
Lytkin Anton
Hardware Development
3DiVi, Russia


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

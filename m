From: leva@despammed.com (Lev A. Melnikovsky)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: AS99127F PWM: how to explore
Message-Id: <Pine.LNX.4.62.0505070203410.3377@nev.ubzr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

Sorry for my previous message, I hoped to get some response from the 
mailing list robot...

I have recently tried to communicate with ASUS people about this chip and 
the answer was "information is confidential". I have a couple of ASUS 
motherboards here, so I want to figure out how it works myself. Now the 
question is if there is some simple way to control these registers? I am 
using 2.4.30 kernel with the lm_sensors-2.9.1. Everything works fine but 
PWM and some BEEP flags. Is there a simple script to be run from userspace 
or I should patch the driver to have raw registers control? I'm going to 
connect oscilloscope to fan power pins to see the effect. Any advice is 
appreciated. Yes, I have read doc/chips/w83781d :-)

Thanks
-L.

From: gawrysz@camk.edu.pl (Artur Gawryszczak)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: [as99127f] - a note about measuring CPU temperature on Asus CUV4X
Message-Id: <200302112308.19507@phoenix.camk.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


There is a question in sensors.conf.eg

# does anyone know a board for which the following is correct?
#   compute temp2 (@*30/43)+25, (@-25)*43/30

... and my answer is: Yes, I know :-) It's Asus CUV4X

Quite recently I did some experiments with this board, and overclocked 
iCII600@(900?950), V_core=(1.8?2.0)V. I'm not extremely hard 
overclocker, but I like to know what's going on, and what are the 
limits for my machine to be rock-stable.

First, I connected a probe, and make sure it's showing right 
temperatures. In my hand it showed +35?C, and in water-snow mixture it 
was about +2?C. Conversion formula "temp3 @*2.0" works good. 
Then I've put the probe between heatsink and the processor, as near the 
silicon core, as possible. I've stressed the CPU for some hours using 
mprime and burnP6, and collected measurements from the probe, and from 
thermal diode. Here you can find the graph showing, that formula 
"(@*30/43)+25" works much better: 

http://www.camk.edu.pl/~gawrysz/as99127f-i2c-0-2d.png (~10kB)

Readouts from CPU diode seems to be very noisy, but in BIOS they behave 
similarly.

I'm using lm_sensors 2.6.5. I've tried 2.7.0, but something was wrong, 
and they didn't work. Probably because there were duplicate temp2 
entries in /proc/....../as99127f-i2c-0-2d directory. I didn't have time 
to find out if I did something wrong, or there is a bug in as99127f 
module.

-- 
Greetings,
        Artur

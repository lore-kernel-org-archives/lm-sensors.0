From: gawrysz@camk.edu.pl (Artur Gawryszczak)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-amd756.o and SMBus collisions, timeouts, lockups
Message-Id: <200308011117.39975@phoenix.camk.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm using lm_sensors 2.7.0 on a mini-cluster, which consists of 8 Dual-Athlon 
nodes running on Tyan Tiger motherboards (two of them have older AMD760MP 
chipset, six have 760MPX). Kernel version is 2.4.19. 

During last 4 months I've noticed two failures related to lm_sensors i this 
cluster. In both cases machines stopped responding, logged strange values of 
temperatures and voltages, and finally, mondo daemon succeeded to shutdown 
them (mondo was set to protect machines from overheating due to fan failures  
and does `halt -fp' if something seems to be going wrong). 

Here comes part of the log from /var/log/messages

Aug  1 05:30:03 onyx kernel: i2c-amd756.o: SMBus collision!
Aug  1 05:30:08 onyx kernel: i2c-amd756.o: Busy wait timeout! (0800)
Aug  1 05:30:08 onyx kernel: i2c-amd756.o: Sending abort.

Mondo wants to read sensors every 5 sec, so it was repeated many times, until 
the machine went down. It's worth to note, that it took ~40 minutes to halt 
the machine, normally `halt -fp' should do a poweroff within few seconds. 
Another software, that reads the sensors is gkrellmd - is it possible, that 
problem comes from simultanous attempts to read the sensors chip?

I don't know how to reproduce this behavior, it occurs so rarely (two cases on 
8 machines in 4 months gives a MTBF > 1 year), and, unfortunately, I had no 
chance to get the console just as the error occurred as yet, because I was 
away from server room.

-- 
Greetings
Artur Gawryszczak

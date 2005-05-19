From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-amd756.o and SMBus collisions, timeouts, lockups
Message-Id: <20030801113356.44ff7068.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308011117.39975@phoenix.camk.edu.pl>
In-Reply-To: <200308011117.39975@phoenix.camk.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm using lm_sensors 2.7.0 on a mini-cluster, which consists of 8
> Dual-Athlon nodes running on Tyan Tiger motherboards (two of them have
> older AMD760MP chipset, six have 760MPX). Kernel version is 2.4.19. 
> 
> During last 4 months I've noticed two failures related to lm_sensors i
> this cluster. In both cases machines stopped responding, logged
> strange values of temperatures and voltages, and finally, mondo daemon
> succeeded to shutdown them (mondo was set to protect machines from
> overheating due to fan failures  and does `halt -fp' if something
> seems to be going wrong). 
> 
> Here comes part of the log from /var/log/messages
> 
> Aug  1 05:30:03 onyx kernel: i2c-amd756.o: SMBus collision!
> Aug  1 05:30:08 onyx kernel: i2c-amd756.o: Busy wait timeout! (0800)
> Aug  1 05:30:08 onyx kernel: i2c-amd756.o: Sending abort.

Hi Artur,

I just wanted to let you know that another user, Charles Lepple, as
reported a similar problem some days ago. Though we have no solution
yet, you may want to read the thread:
http://archives.andrew.net.au/lm-sensors/msg03681.html

I would recommend to both of you to update to i2c and lm_sensors 2.8.0
(unless you are using a 2.5/2.6 kernel), since significant changes have
been made to almost all drivers.

Apart from that, I'm in no way an I2C/SMBus bus driver expert, so I'll
keep quiet and let the other members of the list speak up.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

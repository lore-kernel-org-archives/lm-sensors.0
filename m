From: wildz@videotron.ca (David Lauzon)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Sensor chip - Asus ASM58 Mozart-2
Message-Id: <1043937006.31089.19.camel@stag02.ccs.usherbrooke.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi! 

We're working on a 180 nodes Cluster and we trying to monitor the cpu
temperature on these PC. This project is our prototype for the Mammouth
Project starting this summer : a 1024 nodes cluster.

In the present time, we uses two kind of motherboard :

* 144 Asus P4B533-VM 
  south chipset = ICH4 
  sensor chip   = ASM58 Mozart-2 (Asus' proprietary chip) 

* 36 Asus P4S333-M 
  south chipset = sis961. 
  sensor chip   = ASM58 Mozart-2 

LM Sensors does not support the Mozart-2 chip, but I found Mbmon,
another program which support it. So with the help of the author, we
manage to get his program working on the 144 first motherboards. But
Mmbon doesn't support the sis961 chipset and his author does not have
time to implement such support. So I would like to know if you're
planning on making a driver for the Mozart-2 chip (i know it says ?not
planned? on your website, but i'm just asking... )

Or you know any other way to get the cpu heat, fan speed,etc
informations. I imagine if the BIOS can show us this information, he
must keep it somewhere in memory.. is there a way to read it via a BIOS
function/interruption or memory access? i could not find any information
about this on web.


Thanks in advance, 

------------ 
David Lauzon 
Centre de Calcul Scientifique 
Universit? de Sherbrooke 
Sherbrooke (Qu?bec, Canada) 
J1K 2R1 

Tel.    : (819) 821-8000 #1988

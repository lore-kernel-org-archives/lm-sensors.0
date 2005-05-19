From: vence@fromru.com (Vyacheslav Sokolov)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: lm_sensors on Tyan S2460
Message-Id: <3CA3526A.5000806@fromru.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have installed lm_sensors 2.6.3 but I am still in trouble 
with my Tyan S2460 Tiger MP (rev. 1.03) motherboard. 

Is this motherboad supported? How must I proceed to make lm_sensors work?

I have read all the tickets and I try as follows: 

I go into BIOS before booting to initialize w83627hf; 
then 
# modprobe w83781d init=0 force_subclients=0,0x2c,0x4a,0x4b 

I find that the w83782d shows reasonable temperatures with "set sensor1,2,3 2" (transistor) 
in /etc/modules.conf.
However the w83627hf _does not_ recognize such lines as "set sensor1 2"  and _always_ says
it works with thermistor. Accordingly, the temperatures have no sense.

Is there any workaround to get true temperatures (and voltages as well...)? 

Thanking you in advance,
Sincerely
V.Sokolov


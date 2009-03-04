From: Zbigniew Luszpinski <zbiggy@o2.pl>
Date: Wed, 04 Mar 2009 13:38:45 +0000
Subject: [lm-sensors] Found unknown SMBus adapter 10de:0752 - how can I help
Message-Id: <200903041438.45638.zbiggy@o2.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have ASRock K10N78FullHD-hSLI 3.0 mainboard.
lm_sensors 3.1.0->sensors-detect returns this:
Found unknown SMBus adapter 10de:0752 at 0000:00:01.1.
Sorry, no supported PCI bus adapters found.

lspci finds:
00:01.1 SMBus [0c05]: nVidia Corporation MCP78S [GeForce 8200] SMBus 
[10de:0752] (rev a1)

How can I help supporting it?
I think this might be gpu temperature sensor.

have a nice day,
Zbigniew 'zbiggy' Luszpinski

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

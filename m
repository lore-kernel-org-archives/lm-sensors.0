From: "Eric A. Hall" <eric.hall@gmail.com>
Date: Mon, 20 Sep 2010 14:01:32 +0000
Subject: [lm-sensors] please make smart module for lm_sensors
Message-Id: <4C97693C.7050908@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The lm_sensors documentation says that the smartmontools package should be
used to gather and display hard drive sensor readings. While the smart
tools are certainly very nice as a separate package, it would be very
helpful if the smart data was integrated with lm_sensors so that the HD
temperature could be displayed alongside all of the other sensor data (EG,
desktop applets, SNMP agents, and other tools that use the sensor
libraries already). Perhaps a stub sensor module that read data from
smartd and published it to lmsensors?


I filed the same feature req with the smartmontools tracker but wanted to
make the request here too since you folks might make this happen sooner

http://sourceforge.net/apps/trac/smartmontools/ticket/100
	
Thanks


-- 
Eric A. Hall                                  http://www.eric-a-hall.com/
Network Technology Research Group                    http://www.ntrg.com/
Internet Core Protocols          http://www.oreilly.com/catalog/coreprot/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

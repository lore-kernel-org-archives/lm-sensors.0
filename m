From: <linuxjagnut@cox.net>
Date: Thu, 05 Mar 2009 21:46:26 +0000
Subject: [lm-sensors] no lines in rrd graphs from sensord
Message-Id: <20090305164626.58YK4.419625.imail@fed1rmwml30>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I have configured lm_sensors on my system and normal output shows up when I run the sensors command line client.

$ sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +33.0°C                                    
Core1 Temp:  +31.0°C                                    

it8716-isa-0290
Adapter: ISA adapter
VCore:       +1.10 V  (min =  +0.00 V, max =  +4.08 V)   
VDDR:        +2.48 V  (min =  +1.28 V, max =  +1.68 V)   ALARM
+3.3V:       +1.89 V  (min =  +2.78 V, max =  +3.78 V)   ALARM
+5V:         +5.73 V  (min =  +4.49 V, max =  +5.48 V)   ALARM
+12V:        +4.86 V  (min =  +9.98 V, max = +13.95 V)   ALARM
in5:         +1.17 V  (min =  +0.58 V, max =  +1.34 V)   
in6:         +2.98 V  (min =  +1.04 V, max =  +1.36 V)   ALARM
5VSB:        +5.13 V  (min =  +4.49 V, max =  +5.48 V)   
VBat:        +3.04 V
fan1:       1634 RPM  (min =   10 RPM)
fan2:          0 RPM  (min =   10 RPM)  ALARM
temp1:       +21.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = thermal diode
temp2:       +35.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = transistor
temp3:       +25.0°C  (low  = +127.0°C, high = +127.0°C)  sensor = transistor
cpu0_vid:   +1.525 V

So next I built sensord that is currently packaged with the 3.1.0 release.
I was able to get it running with the following command line:

/usr/local/sbin/sensord --log-interval 0 --load-average --rrd-file /var/www/html/sensord/sensord.rrd --pid-file /var/www/html/sensord/sensord.pid

and it is running as the apache user on my system and that same user owns the /var/www/html/sensord/ directory. The daemon is running but the size of the rrd file (sensord.rrd from the above command line) does not change size and the time stamp is not updated on the file either.

I can see graphs when I display the URL to the cgi script in my web browser but there are no lines drawn for any graphed output. The bottom of each graph does have a label for the appropriate sensors on my system but no data is being displayed inside the graph itself.
--
Steve DuChene

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

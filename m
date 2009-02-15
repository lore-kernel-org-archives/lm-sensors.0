From: Dean Loros <autocrosser1@gmail.com>
Date: Sun, 15 Feb 2009 19:18:52 +0000
Subject: [lm-sensors] More information on Gigabyte GA-EX58-UD4P
Message-Id: <49986A9C.6000606@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I went to the website & got the most current sensors-detect....Important 
info follows:

Driver `to-be-written' (should be inserted):
   Detects correctly:
   * ISA bus, address 0x290
     Chip `ITE IT8720 Super IO Sensors' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
# no driver for ITE IT8720 Super IO Sensors yet
/usr/bin/sensors -s
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.


So my next question is:  What is the status of the ITE IT8720 driver & 
what can I do to help the process along?

Cheers!!!
Dean Loros

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

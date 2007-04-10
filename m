From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 10 Apr 2007 11:54:43 +0000
Subject: [lm-sensors] dynamic chip support
Message-Id: <461B7F5C.5080409@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I just committed a rewrite of parts of the dyn chip support, changes:
-rewrite dyn chip code, it now uses sensors_feature_get_type() to
  identify sysfs entries. Reasons for this rewrite / bugs fixed:
  -Don't give features like alarms / sensor type / fault flag a
   compute mapping only a normal mapping
  -Don't generate features for sysfs entries like uvent, modalias, etc.
   instead only generate features for features known by
   sensors_feature_get_type()
  -Sort the list of found features logically instead of sorted in alphabet order
   of the sysfs entry. So now it starts with all in entries, then all fan and
   then all temp. Just like the order of most entries in lib/chips.c. Also
   this means that it now contains in0 - in10 in that order and not in0, in10,
   in1 - in9

Some observations, in an ideal world this dyn chipsupport could replace most of 
the 5000 lines of code in prog/sensors/chips.c, however some chips seem to use 
non standard sysfs names <sigh> like remote_temp and zone_xxxxx, etc. I'm 
thinking of adding support to often used non standard names to 
sensors_feature_get_type(), but all in all not having a standard API is not good.

Also I've not added support for pwm features, because AFAIK libsensors is about 
sensors, thus I also was amazed to still see eeprom and edid "feature" lists in 
lib/chips.c

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

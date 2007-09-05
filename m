From: Sebastian Thias <post@sthias.de>
Date: Wed, 05 Sep 2007 11:26:25 +0000
Subject: [lm-sensors] "sensord --rrd-file" cant't find a sensor
Message-Id: <46DE9261.8030900@sthias.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lm-sensors team,

I'm using lm-sensors 2.10.4 / sensord 0.6.3

sensord is able to log my sensor-readings (from a w83793-chip) to syslog
without problems:
--8<-----------------------------------------------------------------
Sep  5 12:54:04 capitol sensord: sensord started
Sep  5 12:54:04 capitol sensord: Chip: w83793-i2c-0-2f
Sep  5 12:54:04 capitol sensord: Adapter: SMBus I801 adapter at 0400
Sep  5 12:54:04 capitol sensord:   VCoreA: 1.23
Sep  5 12:54:04 capitol sensord:   -in0_min: 0.80
-->8-----------------------------------------------------------------

Using
  sensord --rrd-file /var/log/sensord
does not work. It can't initialize the RRD-database, with error-msg:

--8<-----------------------------------------------------------------
Sep  5 12:53:52 capitol sensord: Error creating RRD:
/var/log/sensord.rrd: No sensors detected
-->8-----------------------------------------------------------------

Any idea what could be wrong...?

Thank you very much in advance!

Sebastian Thias

P.S.: please CC to me, as i'm not subscribed to the list. Thanks!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

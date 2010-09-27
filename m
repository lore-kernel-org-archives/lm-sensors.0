From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Mon, 27 Sep 2010 23:54:07 +0000
Subject: Re: [lm-sensors] [patch 01/36] hwmon: New driver for the
Message-Id: <20100927235407.GA18122@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915163447.GB10422@ericsson.com>
In-Reply-To: <20100915163447.GB10422@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It seems to be working so far.  I got this information from SuperMicro,
for their C7X58 and X8SAX motherboards (included here as a direct
transcription from their reply):

Windbond W83795AG, Slave Address=0x2e (0x5c in 8-Bit format)
==============================Fan1/CPU Fan Speed, Offset 0x2e         RPM = 84375/Data
Fan2 Fan Speed, Offset 0x2f             RPM = 84375/Data
Fan3 Fan Speed, Offset 0x30             RPM = 84375/Data
Fan4 Fan Speed, Offset 0x31             RPM = 84375/Data
Fan5 Fan Speed, Offset 0x32             RPM = 84375/Data
Fan6 Fan Speed, Offset 0x33             RPM = 84375/Data
CPU Voltage, Offset 0x10                Voltage = Data* 0.008
DIMM Voltage, Offset 0x12               Voltage = Data* 0.008
+5V Voltage, Offset 0x13                Voltage = Data* 0.008 * (40/10)
+12V Voltage, Offset 0x14               Voltage = Data* 0.008/(10./66.2)
-12V Voltage, Offset 0x15               Voltage = ((Data*0.008-2.048)/Fact)+2.048
+3.3V Voltage, Offset 0x1c              Voltage = Data* 0.024
+3.3VSB Voltage, Offset 0x1d            Voltage = Data* 0.024
Battery Voltage, Offset 0x1e            Voltage = Data* 0.024
CPU Temperature, Offset 0x26            Temperature = Data
System Temperature, Offset 0x20         Temperature = Data

Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40    1 = Bad, 0 Good
                        (Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)

Power Supply Failure, GP31(From W83627DHG-P)    1 = Good, 0 = Bad

Is there any way to access the last two?  Do we export the GPIO pins of
these chips through sysfs at all?

Also, I am wondering what they mean with "Fact" in the -12V reading.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

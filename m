From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: [Fwd: i850 && lm_sensors]
Message-Id: <200307200926.28184.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F16EFDB.4040504@edgedesign.us>
In-Reply-To: <3F16EFDB.4040504@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne ne 20. ?ervence 2003 02:14 jste napsal(a):
> get our new 2.8.0 release and try again to run sensors-detect.
> If it doesn't work email us the output of 'lspci -n'.

I tried it before. It doesn't work.

modules:
i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-i801 version 2.8.0 (20030714)
i2c-dev.o: i2c /dev entries driver module version 2.8.0 (20030714)

results:

Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `Serial EEPROM' (confidence: 8)

only eeprom, no fan speed, etc ...

lspci -n:
00:00.0 Class 0600: 8086:2530 (rev 04)
00:01.0 Class 0604: 8086:2532 (rev 04)
00:1e.0 Class 0604: 8086:244e (rev 04)
00:1f.0 Class 0601: 8086:2440 (rev 04)
00:1f.1 Class 0101: 8086:244b (rev 04)
00:1f.2 Class 0c03: 8086:2442 (rev 04)
00:1f.3 Class 0c05: 8086:2443 (rev 04)
00:1f.5 Class 0401: 8086:2445 (rev 04)
01:00.0 Class 0300: 10de:0253 (rev a3)
02:01.0 Class 0c03: 1033:0035 (rev 41)
02:01.1 Class 0c03: 1033:0035 (rev 41)
02:01.2 Class 0c03: 1033:00e0 (rev 02)
02:0b.0 Class 0200: 10b7:9200 (rev 78)

thanks ...
-- 
Ondrej Cecak


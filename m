From: charles@defenderhosting.com (Charles Galpin)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: i2c-amd756 and dual opteron sensors not found
Message-Id: <E4BDE5C0-688C-11D8-972E-000A958E5EF8@defenderhosting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Feb 26, 2004, at 1:25 PM, Jean Delvare wrote:
>
> Now that I get what the value after the "Failed!" means, I understand
> that I couldn't work anyway.
>
> Please try replacing the value with 0xe9 instead. This will somewhat
> force the detection, and sensors-detect will tell us a bit more (sort 
> of
> "if it was really a W83627THF, it would be in this state, at this
> address"). If the details make sense, we'll continue.

Hopefully this is good news (W83627THF found but not activated)

  Some Super I/O chips may also contain sensors. Super I/O probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8712F Super IO Sensors'
   Failed! (0xe911)
Probing for `SMSC 47M10x Super IO Fan Sensors'
   Failed! (0xe9)
Probing for `SMSC 47M14x Super IO Fan Sensors'
   Failed! (0xe9)
Probing for `VT1211 Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83627HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83627THF Super IO Sensors'
   Success... but not activated, module may not find
Probing for `Winbond W83637HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83697HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83697UF Super IO PWM'
   Failed! (0xe9)

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus AMD756 adapter at 80e0' (Non-I2C SMBus adapter)
     Busdriver `i2c-amd756', I2C address 0x52
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus AMD756 adapter at 80e0' (Non-I2C SMBus adapter)
     Busdriver `i2c-amd756', I2C address 0x53
     Chip `SPD EEPROM' (confidence: 8)

Driver `bmcsensors' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
     Chip `IPMI BMC KCS' (confidence: 4)

>
> If you did not do so yet, you can also try "isadump 0x295 0x296". Note
> that this is potentially dangerous if it happens that this address is
> used by something else (I think you can see in /etc/ioports to make 
> sure
> it's free).

/proc/ioports showed it free, so i tried it :)

[root@opteron root]# isadump 0x295 0x296
   WARNING! Running this program can cause system crashes, data loss and 
worse!
   I will probe address register 0x0295 and data register 0x0296.
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Thanks for the help Jean, and let me know what I can do next.

thanks
charles

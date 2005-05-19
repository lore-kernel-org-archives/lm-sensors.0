From: charles@defenderhosting.com (Charles Galpin)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c-amd756 and dual opteron sensors not found
Message-Id: <02F2E7B0-6700-11D8-972E-000A958E5EF8@defenderhosting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Feb 24, 2004, at 1:58 PM, Jean Delvare wrote:

>> the mainboard is ms-9131 has amd 8111 & 8113 and winbond w83627hf-aw
>
> Please edit sensors-detect. Look for the W83627THF definition array, 
> and
> edit it:
>
> {
>   name => "Winbond W83627THF Super IO Sensors",
>   driver => "w83627hf",
>   addrreg => 0x2e,
>   exitreg => 0x2e,
>   datareg => 0x2f,
>   enter => [0x87, 0x87],
>   devidreg => 0x20,
>   devid => 0x82,
>            ^^^^ write 0x90 instead
>   logdevreg => 0x07,
>   logdev => 0x0b,
>   actreg => 0x30,
>   actmask => 0x01,
>   basereg => 0x60,
>   exit => 0xaa,
> },
>
> Then run sensors detect again and say Y to Super-I/O. Let me know if
> sensors-detect now detects it.

Hi Jean

It does not:

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
   Failed! (0xe9)
Probing for `Winbond W83637HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83697HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83697UF Super IO PWM'
   Failed! (0xe9)

thanks
charles

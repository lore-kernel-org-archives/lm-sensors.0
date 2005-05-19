From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c-amd756 and dual opteron sensors not found
Message-Id: <20040224195830.5b4f9a70.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> the mainboard is ms-9131 has amd 8111 & 8113 and winbond w83627hf-aw

Please edit sensors-detect. Look for the W83627THF definition array, and
edit it:

{
  name => "Winbond W83627THF Super IO Sensors",
  driver => "w83627hf",
  addrreg => 0x2e,
  exitreg => 0x2e,
  datareg => 0x2f,
  enter => [0x87, 0x87],
  devidreg => 0x20,
  devid => 0x82,
           ^^^^ write 0x90 instead
  logdevreg => 0x07,
  logdev => 0x0b,
  actreg => 0x30,
  actmask => 0x01,
  basereg => 0x60,
  exit => 0xaa,
}, 

Then run sensors detect again and say Y to Super-I/O. Let me know if
sensors-detect now detects it.

Thanks.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

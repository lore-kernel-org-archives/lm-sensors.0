From: cebbert@redhat.com (Chuck Ebbert)
Date: Wed, 21 Feb 2007 16:03:07 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45DC6D3B.80500@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>	<45D6DDCE.5050803@assembler.cz>	<45D7461A.2040808@redhat.com>	<45D8D6AE.3000204@assembler.cz>	<45DB0EEA.2010205@redhat.com> <20070221155444.99386b98.khali@linux-fr.org>
In-Reply-To: <20070221155444.99386b98.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> Can you try to load the i2c-dev driver, then run the following commands
> and report the results:
> $ i2cdetect -l
> For each bus listed:
> $ i2cdetect N

FWIW it's really an ATIIXP chipset, but supposedly PIIX4 compatible:

# i2cdetect -l
i2c-0   smbus           SMBus PIIX4 adapter at 8400             Non-I2C SMBus adapter
# i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX


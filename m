From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <1088718389.2862.87.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
References: <1088690691.2862.25.camel@null>
In-Reply-To: <1088690691.2862.25.camel@null>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2004-07-01 at 23:19, Jean Delvare wrote:

> Andras, please test and confirm that your LM77 is correctly detected as
> a LM77 (with confidence at least 3).

$ sensors-detect
[...]
Next adapter: SCx200 ACB1
Do you want to scan it? (YES/no/selectively):
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Success!
    (confidence 2, driver `lm92')
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
[...]
Driver `lm75' (should be inserted):
  Detects correctly:
  * Bus `SCx200 ACB1' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x48
    Chip `National Semiconductor LM77' (confidence: 3)

Driver `lm92' (may not be inserted):
  Misdetects:
  * Bus `SCx200 ACB1' (Algorithm unavailable)
    Busdriver `UNKNOWN', I2C address 0x48
    Chip `National Semiconductor LM76' (confidence: 2)

Just as a thought: if the kernel is compiled w/o modules,
/proc/modules does not exist, so initialize_modules_list()
will fail. Maybe it should just silently return if the
file does not exist...

Thanks,
Andras


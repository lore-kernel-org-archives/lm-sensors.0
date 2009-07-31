From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Fri, 31 Jul 2009 00:39:57 +0000
Subject: [lm-sensors] [PATCH v2 0/6] Device table matching for SPI subsystem
Message-Id: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ben Dooks <ben@fluff.org>, David Brownell <dbrownell@users.sourceforge.net>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean Delvare <khali@linux-fr.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

Andrew,

This new patch set overwrites following patches:

  hwmon-lm70-convert-to-device-table-matching.patch
  hwmon-adxx-convert-to-device-table-matching.patch
  spi-merge-probe-and-probe_id-callbacks.patch
  spi-prefix-modalias-with-spi.patch
  of-remove-stmm25p40-alias.patch
  mtd-m25p80-convert-to-device-table-matching.patch
  spi-add-support-for-device-table-matching.patch


Changes since v1:

- Implemented Ben Dooks' idea of spi_get_device_id(), so we won't
  call spi_match_id() twice for drivers that don't need the id.

- "spi: Merge probe and probe_id callbacks" patch no longer needed
  as we don't change probe()'s arguments;

- Rename spi_device_id->data to driver_data, and turn it into
  kernel_ulong_t to match majority of subsystems. Most drivers
  don't need a pointer type anyway (e.g. m25p80 needs it, but
  lm70 and adcxx don't);

- SPI_NAME_SIZE now defined to 32 (as it should be, using 20
  for name size was a cut-n-paste typo from I2C defines).


Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

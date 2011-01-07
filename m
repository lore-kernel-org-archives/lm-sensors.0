From: Roland Stigge <stigge@antcom.de>
Date: Fri, 07 Jan 2011 10:37:15 +0000
Subject: [lm-sensors] Use of swab16() in drivers/hwmon/*.c
Message-Id: <4D26ECDB.7010602@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I wonder about a specific use of swab16() in several files
in drivers/hwmon/.

Consider ds1621.c: We get big endian words from
i2c_smbus_read_word_data(). To use it on a little endian arch, the
driver uses swab16() for conversion by swapping bytes unconditionally.

IMHO this is not suitable on a big endian architecture. Shouldn't it be
sth. like be16_to_cpu()?

Thanks in advance.

bye,
  Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

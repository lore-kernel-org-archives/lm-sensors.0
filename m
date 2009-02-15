From: "Fred ." <eldmannen@gmail.com>
Date: Sun, 15 Feb 2009 15:13:16 +0000
Subject: [lm-sensors] Does lm-sensors support chassis intrusion for Fintek
Message-Id: <f188924b0902150713q43addf9g94851a4d581b411e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am using lm-sensors on a MSI P35 Neo (MS-7360) motherboard which
uses Fintek f71882fg super-I/O circuit.

The Fintek f71882fg is listed as supported by lm-sensors according to
the lm-sensors wiki.
Source: http://www.lm-sensors.org/wiki/Devices

This super-I/O does support chassis intrusion according to the Fintek datasheet.
Source: http://www.fintek.com.tw/files/productfiles/F71882_V028P.pdf

On the wiki, I also found a example configuration file for my MSI P35
Neo motherboard.
Source: http://www.lm-sensors.org/wiki/Configurations/MSI/P35-Neo

The config file includes references to Fintek f71882fg
Source: http://www.lm-sensors.org/browser/lm-sensors/trunk/etc/sensors.conf.eg?revV43

My motherboard and super-io circuit does support chassis intrusion detection.
I know that lm-sensors does support chassis intrusion detection.
Does lm-sensors support this feature on my motherboard/superio?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

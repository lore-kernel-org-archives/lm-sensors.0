From: eu@celuloza.ro (Radu Anghel)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: lm_sensors and kernel 2.6.1
Message-Id: <1073648608.1269.3.camel@bubursuc.celuloza.ro>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

has anything changed in sysfs since 2.6.0?
because on 2.6.0 sensors worked, now it says:

[eu:pts/1][~]$ sensors
via686a-isa-6000
Adapter: ISA adapter
Algorithm: ISA algorithm
ERROR: Can't get alarm data!
CPU core:  +1.53 V  (min =  +1.79 V, max =  +2.18 V)
+2.5V:     +0.00 V  (min =  +2.24 V, max =  +2.74 V)
I/O:       +3.33 V  (min =  +2.95 V, max =  +3.62 V)
+5V:       +5.17 V  (min =  +4.47 V, max =  +5.49 V)
+12V:     +12.46 V  (min = +10.79 V, max = +13.18 V)
CPU Fan:  5075 RPM  (min = 3000 RPM, div = 2)
P/S Fan:     0 RPM  (min = 3000 RPM, div = 2)
ERROR: Can't get TEMP data!
ERROR: Can't get TEMP2 data!
ERROR: Can't get TEMP3 data!

PS. gkrellm can read the temp values

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040109/144e82b5/attachment.bin

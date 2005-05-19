From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: PATCH: bmcsensors port to 2.6.7, associated patch for
Message-Id: <2538186704071412096450d7e0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Attached is my port of the ipmi bmcsensors driver (along with
associated i2c-ipmi dummy driver) from 2.4 to 2.6.7. Also attached you
will find a patch allowing the lm_sensors 2.8.7 userspace utilities to
work with the driver.

The patches have been tested and works on my machine (HP x4000
Workstation w/ early IPMI 1.0 implementation) and could do with some
more testing on other ipmi implementations. Obviously ipmi is not
widespread yet, so any testing help and feedback is very much
appreciated.

Thanks,
Yani

P.S. Could someone add me to this mailing list? :-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-lm_sensors-2.8.7-bmcsensors.diff.gz
Type: application/gzip
Size: 1820 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040714/0d5cdc38/patch-lm_sensors-2.8.7-bmcsensors.diff.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.7-bmcsensors.diff.gz
Type: application/gzip
Size: 14175 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040714/0d5cdc38/patch-linux-2.6.7-bmcsensors.diff.bin

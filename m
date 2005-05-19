From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: sensors in 2.5.54!!!
Message-Id: <3E17A4B8.8060706@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

great news.

The patch for i2c-amd756, i2c-amd8111, adm1021, and lm75,
submitted by Pavel Machek, has been included,
with modifications, in kernel 2.5.54 by Cristoph Hellwig.
As you can see from the patch notes below, there were
several modifications to the drivers and to the i2c core.

Any volunteers to work with Cristoph to feed more drivers in?
Pavel?

Note that we'll have to go through the changes he made,
figure them out, backport them into CVS, and apply
to the other drivers.

This will be somewhat easier after we remove 2.2 support.
But there are still several 2.4<->2.5 differences which
we will have to keep out of CVS, or at least #ifdef,
and the patcher will have to deal with those.

Also note that the drivers went into i2c/busses and i2c/chips,
so I think that solves that debate. I'll update our
makefiles and mkpatch to put them there and remove
old modules in i2c/ and sensors/ .

mds

----------------

Christoph Hellwig <hch@lst.de>:
  o remove CONFIG_X86_NUMA
  o nommu systems can't support /proc/<pid>/maps
  o rewrite i2c-amd756 to resemble a linux driver
  o check_region remove for drivers/i2c/
  o make i2c use initcalls everywhere
  o more deprectation bits
  o avoid deprecated module functions in core code
  o clean up subarchitecture selection
  o remove superflous module use count handling in jbd
  o more module warning fixes
  o get rid of TRUE/FALSE abuse in the scsi midlayer
  o fix i2c module handling
  o i2c updates
  o remove obsolete i2c headers
  o more obsolete module API fixes
  o rename CONFIG_VOYAGER to CONFIG_X86_VOYAGER
  o Missed one 'try_inc_mod_count()'
  o fix fs/dquot.c compilation
  o more i2c cruft removal
  o include <linux/vfs.h> only in files actually needing it
  o devfs creptomancy
  o some ppp/usecount bug

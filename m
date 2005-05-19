From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: ---=== Lm_sensors Support DB Entry #1692 ===---
Message-Id: <20040609225238.7773c9e2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040609062212.GC448@skilta.cc.tut.fi>
In-Reply-To: <20040609062212.GC448@skilta.cc.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timo,

I made the necessary changes, you can get the files here:

http://jdelvare.net1.nerim.net/sensors/linux-2.6.7-rc3-i2c-lm86.diff
http://jdelvare.net1.nerim.net/sensors/lm_sensors2-lm86.tar.gz

First file is a kernel patch that adds support for the LM86 to the lm90
driver.

Second file is a CVS snapshot of lm_sensors2 including my changes to
support the LM86 (and a few others you probably don't care about). I
cannot commit them now because we are in feature freeze state, so I
thought I would make my tree available to you in case you want to test
the changes.

All this is untested since I don't own an LM86 chip myself.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

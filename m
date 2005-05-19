From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: W83697HF detection problem and sensor segmentation fault
Message-Id: <20030419164009.GA12011@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EA16D32.7050109@cluster-labs.com>
In-Reply-To: <3EA16D32.7050109@cluster-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Norbert Roos <norbert.roos@cluster-labs.com> [2003-04-19 17:37:22 +0200]:

> lm-sensors version 2.7.0 with a 2.4.20 kernel, i2c used as module.
> Hardware is a W83697HF connected to a SiS962 south bridge (with LPC bus).

<cut>

> Next, i'm doing from what sensors-detect told me:
> 
> modprobe i2c-isa
> modprobe sis5595

Don't modprobe sis5595, you don't have one of those.  SiS96x are
often mis-detected as SiS5595.

<cut>

> Module                  Size  Used by    Not tainted
> w83781d                19408   0
> sis5595                 6536   0  (unused)
> i2c-proc                6928   0  [w83781d sis5595]
> i2c-isa                 1128   0  (unused)
> i2c-dev                 4164   0
> i2c-sis5595             3820   0
> i2c-core               13960   0  [w83781d sis5595 i2c-proc i2c-isa 
> i2c-dev i2c-sis5595]

<cut>

> Do you have any ideas how to proceed?

Make sure to load neither sis5595 nor i2c-sis5595.  You may want to
try loading i2c-sis645 instead (although perhaps you don't need it,
if your w83697hf is ISA accessible.)  Let us know if that doesn't help.

Also make sure you have no old sensors libraries hanging around from
RPMS or whatnot.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

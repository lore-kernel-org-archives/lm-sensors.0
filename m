From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 01 Sep 2005 00:11:18 +0000
Subject: [lm-sensors] [patch 0/2] pc87360 vref-int-ext - readme
Message-Id: <200508312210.j7VMARRJ008318@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patchset has 2 parts, a bug-fix and a feature-add

01	pc87360-01-fix-vref-ext-int-mixup.patch

fixes a 1-line bug in the internal vs external voltage reference
selection, Old code used vrefint when vrefext was chosen, and vice
versa.

Henrik Brix Andersen, who also has this chip on his soekris 4801,
has indicated this improved the accuracy of his readings.


02	pc87360-02-vref-options.patch  *(RFC)*

adds 3 new module-parameters, which allow the well-equipped user to
improve the accuracy of her on-board voltage measurements.  

Im seeking input for whether any/all of these parameters are useful or
excessive, and where any additional commentary should go - Ive not put
it in the parameter-info, though that would be the most usable place
for it; I dont know the norms for verbosity here, and Ive already
added a 2nd line for each.

The following comments could reasonably go into Docs, but if so, where
- theres none currently, and it feels a bit presumptuous to create it
anew.

The 3 params, most usable 1st, are:


+module_param(vrefext, int, 0);

The PC87366 Spec recommends a that a voltage of 1.211 volts be fed to
the external vref input, so the code matches that expectation, but
your board may differ.  If you measure your boards actual voltage, you
can tell the driver aobout it.

This param could be used to workaround the bug fixed by the 1st patch,
and ironically, it is more verifiable without that bug fixed.


+module_param(vrefscale, int, 0);

If you *also* measure several of the other reported voltages, you can
do some math (y=mx+b) to determine where your scaling factor is in the
specified range; 2.45 V +/- 50 mV.  This parameter is clamped to that
range.


+module_param(vrefint, int, 0);

If youve tweaked both of the above, *and* have the ability to switch
to an internal voltage reference, you can then do more math (y=mx+b)
to determine what the internal voltage ref really is.


[jimc@harpo pset-pc87360-vref]$ diffstat pc87360-0*
 V-1/drivers/hwmon/pc87360.c |    2 +-
 V-2/drivers/hwmon/pc87360.c |   30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>


From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 12 Oct 2007 08:46:44 +0000
Subject: [lm-sensors] lm-sens 2.10.5 fschmd support
Message-Id: <470F3474.5040809@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I've just committed support for the new fschmd to trunk, so that it will be 
available in 2.10.5

It would be much appreciated if people who have an fsc chip could test the 
current trunk with it. I've been very carefull to make sure there will be no 
regressions.

Also a quick review would be nice.

Here is the changelog entry:

This patchset adds support for the new fschmd driver, while keeping
compatibility with the old:
-The feature lists for the fscpos, fscscy and fscher have been extended to
  include the new features exported by the fschmd driver
-Feature lists for the fschmd and fschrc have been added
-The print functions in "sensors" for the fscpos, fscscy and fscher have
  been modified to detect on which driver they run, on the old driver
  behaviour is unmodified, on the new driver the non sysfs-interface
  compliant attributes are not used and the extra features exported by the
  new driver are shown.
-print functions for the fschmd and fschrc have been added to "sensors"
-mapping from the non standard sysfs attr name fan#_ripple used by the old
  fscpos, fscscy and fscher drivers to the standard fan#_div used by the
  fschmd driver has been added to getsysname() using altsysname.


Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

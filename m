From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Oct 2010 15:38:25 +0000
Subject: [lm-sensors] [PATCH v2 0/3] hwmon: (lm90) Add support for
Message-Id: <1286293108-28890-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This series of patches introduces support for the update_interval sysfs
attribute to the lm90 driver. 

v2 changes:
- Removed code rearrangement patch from patchset, since it was already applied.
  Note that this patchset depends on the code rearrangement patch.
- code review changes included. Key functional changes are:
  - introduced data structure for chip specific parameters
  - replaced update interval calculation code. Got rid of conversion table, 
    and use rounding to determine closest update interval.
  - next update in lm90_update_device() is now much closer to chip update
    interval.
- split patchset into three patches. 
  The first patch introduces a data structure to define chip specific parameters.
  The second patch defines LM90_HAVE_BROKEN_ALERT, to be used for chips where 
  ALERT has to be be disabled after an interrupt.
  The third patch introduces update_interval.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jan 2012 00:21:21 +0000
Subject: [lm-sensors] [PATCH 0/3] Patch series for lm-sensors
Message-Id: <1326068484-1898-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Added code to detect IT8510E.
Separated code to add support for new sensors into two patches.

v3:
- Separated into two patches, one to automatically handle array sizes and one
  to add new sensors.
- Fixed array size calculations (in array size patch)
- Removed code to display average power in addition to instantaneous power if
  both are available.
- In doc/libsensors-API.txt, moved new attributes to new version entry.
  Not sure what is correct here, and if the API version number needs to change.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 09:31:11 +0000
Subject: [lm-sensors] lm-sensors 3.0.0-rc2 to be released soon
Message-Id: <20071007113111.2e0a275f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I plan to release lm-sensors 3.0.0-rc2 tomorrow or the day after. The
changes from rc1 are as follows (from CHANGES):

  Makefile: Add sensors-conf-convert to make install
  libsensors: Notify the caller when writing a value fails
              Differentiate between different read error types
              Report I/O errors as such
  sensord: Log the error code on failure
           Drop the configuration file search path mechanism (#2259)
           Manual page update
  sensors: Fix spurious critical temperature alarm
           Print error messages to stderr
           Make error messages more helpful and consistent
           Better handling of the fault flags
  sensors-conf-convert: Add a short help text
  sensors-detect: Fix SMSC SCH311x detection


I am not yet sure if this will be the last release candidate before the
final release. On the one hand, it seems to work really well, but on
the other hand I really would like at least one additional application
to be ported to the new libsensors API to confirm that it is OK.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

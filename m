From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Aug 2007 20:54:54 +0000
Subject: [lm-sensors] Misc API changes for libsensors4
Message-Id: <20070817225454.2e3bc43d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As libsensors4 won't be compatible with libsensors3 (thus the major
version number change) it's the right time for small adjustments to the
API, which we won't be allowed to do later. After reviewing the current
API, I have the following proposals, and I would like to know if there
are objections to me doing these changes.

* Drop support for reloading the configuration from sensors_init().
Instead, the application will have to call sensors_exit() explicitly
before calling sensors_init() again. Rationale: most applications don't
offer any way to reload the configuration file, so better optimize for
the initial load.

* Change the prototype of sensors_get_label() from
	int sensors_get_label(const sensors_chip_name *name, int feature, char **result)
to
	char *sensors_get_label(const sensors_chip_name *name, int feature)

Errors can be reported with a NULL pointer.

* Rename sensors_get_feature() and sensors_set_feature() to
sensors_get_value() and sensors_set_value(), respectively. Rationale:
the new names better reflect what the functions do.

* Change the prototype of sensors_get_detected_chips from
	const sensors_chip_name *sensors_get_detected_chips(int *nr)
to
	const sensors_chip_name *sensors_get_detected_chips(const sensors_chip_name *name, int *nr)

The application would pass a chip name possibly containing wildcards,
so sensors_get_detected_chips() could check for matches itself (using
sensors_match_chip). Passing an all-wildcard chip name (or NULL?) would
restore the old behavior. This makes it easier to let the user chose a
subset of chips to print (as can be done with sensors' command line) by
moving the code into the library. We may then be able to make
sensors_match_chip private, as this is the last use in sensors and
sensord.

* Drop SENSORS_MODE_NO_RW and SENSORS_MODE_RW. The mode is a bitfield,
we typically set, or test for, a specific bit. As a matter of fact,
these two symbols aren't used anywhere in libsensors, sensors, sensord,
ksensors nor xsensors.

If anyone has objections or comments, please let me know.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

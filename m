From: Christopher Head <headch@gmail.com>
Date: Wed, 14 Mar 2012 18:55:47 +0000
Subject: [lm-sensors] Reverse iteration of config files breaks SET overrides
Message-Id: <20120314115547.52f25913@ritchie.cs.ubc.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
The function sensors_do_chip_sets calls sensors_do_this_chip_sets. The
latter function iterates configuration blocks using
sensors_for_all_config_chips. For each configuration block, it iterates
all SET statements and applies each one using sensor_set_value.
However, sensors_for_all_config_chips returns the configuration blocks
backwards, with the expectation that it's being used to find a
particular value and thus the "last" one (either in /etc/sensors.d or
else the last value in /etc/sensors.conf) is the one the caller cares
about. This means that the last SET statement applied to sysfs (i.e.
the only one that matters) is actually the earliest one in
configuration order, that is, the topmost in /etc/sensors.conf. This
completely breaks the comment at the top of /etc/sensors.conf that all
local tweaks should be placed in /etc/sensors.d, because such tweaks
are ignored if a SET statement for the same variable appears
in /etc/sensors.conf.

Thanks for the consideration!
Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

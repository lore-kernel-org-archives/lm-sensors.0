From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Mobo-specific config files
Message-Id: <200405261109.i4QB9oSe022486@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

I plan to create a "mobo" directory under lm_sensors2/etc, where we
could store mobo-specific configuration files. It's not meant to be
exhaustive, but at least it would be a placeholder for config files sent
by the users. There have been several attempts to do this using
databases and web forms so that the users can feed the base without our
help, but none of them succeeded. So maybe hosting the files ourselves
would be better.

I plan to have a single, flat list of files in the subdirectory, in the
form <manufacturer>-<model>.conf. It could also be possible to have a
subdirectory for each manufacturer. I have no strong opinion.

The reason why I propose this now is that manufacturers using the PC87366
chip did not follow National's recommendations for input voltages, so
the configurations for the three motherboards I know about as of now
have almost nothing in common. I'd like to have separate configuration
files for these.

Thanks,
Jean

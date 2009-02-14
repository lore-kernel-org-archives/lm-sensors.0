From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Feb 2009 11:31:29 +0000
Subject: [lm-sensors] Call for 3.1.0
Message-Id: <20090214123129.341cba0e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Feb 2009 14:08:42 +0100, Jean Delvare wrote:
> It's been quite some time since lm-sensors 3.0.3 was released (end of
> September 2008, that's 4.5 months ago) and I think it's about time to
> push a new release out. Given the number of big changes in the upcoming
> release I plan to renumber it from 3.0.4 to 3.1.0.
> 
> The major changes in this release will be:
> * Completely reworked sensors-detect. Support for Linux 2.4 was
>   dropped, devices probe order was reverted (integrated sensors first,
>   I2C/SMBus chips last), bus driver names are retrieved from sysfs, bus
>   number prediction was fixed, modules we loaded ourselves are unloaded.
>   The script is significantly smaller, and smarter.
> * Improvements to libsensors. Circular dependencies in the
>   configuration file are detected and dealt with, and more importantly,
>   support for multiple configuration files was (well, is being) added.
>   This is an important step in the direction of automatic lm-sensors
>   configuration. Also some performance and memory usage improvements.
>   Support for instantaneous power sensors and current sensors.
> * The format of /etc/sysconfig/lm_sensors was changed. The new format
>   is easier to edit, which will ease integration with external tools.
> * New default sensors.conf file. Much lighter, with only always-correct
>   statements. Big performance boost, and hopefully less confusion for
>   the user.
> * And as usual, random fixes to all tools.
> 
> As some of these changes are pretty intrusive, I expect some problems.
> This release will require some serious testing. The proposed version
> number (3.1.0) hopefully reflects this.

Proposed schedule for the 3.1.0 release:

* February 21st: SVN freeze.
* February 22nd to 27th: testing.
* February 28th: release.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

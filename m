From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Mar 2011 07:48:24 +0000
Subject: [lm-sensors] lm-sensors 3.3.0 has been released!
Message-Id: <20110328094824.66a37c40@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just released lm-sensors 3.3.0 as announced ten days ago.
This release adds support for intrusion detection and humidity sensors,
as well as many new attributes for existing sensor types.

Most important changes are:
* Support for intrusion detection sensors.
* Support for humidity sensors.
* Support for many subfeatures implemented by new hwmon drivers.
* Some arbitrary limits removed from libsensors.
* New generic limit printing code in "sensors".
* New chips known by sensors-detect, as usual.

See CHANGES for the details.

Phil, please copy the new release to your mirror as your time permits.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

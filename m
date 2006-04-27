From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 27 Apr 2006 07:57:29 +0000
Subject: [lm-sensors] Dell Latitude D610 and 2.6.16
Message-Id: <20060427095729.aa2d40cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060421050124.GY14481@daedalus.andrew.net.au>
In-Reply-To: <20060421050124.GY14481@daedalus.andrew.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

> I just thought I'd try out lm-sensors on my Dell D610 with what's in 2.6.16,
> and sensors-detect decided that i2c-i801 and eeprom should be loaded, but
> the sensors command fails, and there's nothing in /sys/class/hwmon (where I
> presume from stracing sensors there is supposed to be something).
> 
> Should this work with this hardware?

The result you have is consistent with the drivers you loaded (which in
turn sound OK for your hardware, I have a Dell Latitude D600 and I use
the same drivers.) The sensors program and libsensors library were
modified in lm_sensors 2.10.0 not to show non-sensors devices anymore
(at least for 2.6 kernels.) EEPROMs are not sensors so it didn't belong
there in the first place.

You can obtain information from your EEPROMs by using the
decode-dimms.pl script from the lm_sensors package instead.

-- 
Jean Delvare


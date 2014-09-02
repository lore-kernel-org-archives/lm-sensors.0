From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 02 Sep 2014 08:07:53 +0000
Subject: Re: [lm-sensors] ITE8620E Weird Buzzer
Message-Id: <20140902100753.333342e3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Aug 2014 09:00:44 -0500, hceuterpe@gmail.com wrote:
> I own a Gigabyte Z97 with an ITE8620E. I followed the guidance of forcing
> the it87 module with the 8728 chip since the one I have hasn't been ironed
> out quite yet. I intentionally disabled the high temperature CPU, PCH and
> system buzzer warnings in the BIOS, along with the minimum fan RPMs.
> Identified individual fan RPMs by manually stopping them with either my
> fingers or a trusty cotton swab to compare RPMs and setting unused fan
> headers to ignored in the conference file. Even got the voltage multipliers
> configured.  It appears however that randomly, the case speaker buzzer will
> randomly go off, even when the sensor values are clearly in spec ( CPU temp
> is about 27C at idle, case temp 31C, set minimum fan RPM warning to 0).
> All fans are controlled currently by the BIOS and not an external tool.
> Using CentOS 7.

First note: "ignore"d inputs will still trigger alarms if they go off
limits. So when you "ignore" an input, you may also have to set its
limits to the minimum/maximum possible values to avoid spurious alarms.

If that doesn't help, you can check the value of attributes in0_beep,
fan1_beep (or whatever the first fan is) and temp1_beep. If any is set
to 1, try setting it to 0. I don't think plain "sensors" shows these,
but "sensors -u" should. You can set the values in your sensors.conf
file and apply the changes with "sensors -s".

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

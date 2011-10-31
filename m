From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 31 Oct 2011 13:18:14 +0000
Subject: [lm-sensors] max1111 doesn't implement the standard sysfs interface
Message-Id: <20111031141814.79b5aa69@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031141642.0ed2ccc1@endymion.delvare>
In-Reply-To: <20111031141642.0ed2ccc1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric,

It was pointed to me that the max1111 driver doesn't implement the
standard sysfs interface for hwmon drivers (as described in
Documentation/hwmon/sysfs-interface). It exports files adc[0-3]_in, which
aren't part of the standard interface. Presumably these should be
renamed to in[0-3]_input. Renaming them is probably not sufficient
though, as I see no scaling done in the driver. As the MAX1111 chip has
a documented full scale of 2.048V, I take it that the LSB of the ADC
has a weight of 8 mV. Exporting raw register values to user-space is
not OK.

So I would appreciate a fixup patch quickly. Otherwise we'll have to
remove the max1111 driver completely, so that it doesn't get used as a
(bad) example by other driver authors [1]. I'm sorry I did not spot the
problem when reviewing the driver originally.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2011-October/034070.html

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

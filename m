From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 27 May 2015 09:25:49 +0000
Subject: [lm-sensors] I2C addresses of TMP435
Message-Id: <20150527112549.1e5e0e2f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

In this commit:
http://www.lm-sensors.org/changeset/6260

You listed 0x37 as a possible address for the TMP435. While this is
correct, I don't think we want to probe this address. Currently we do
not probe it for any other chip, and we even removed it explicitly in
the past:
http://www.lm-sensors.org/changeset/3233

In the light of recent reports of display breakage caused by
sensors-detect I would like to play it safe and not probe address 0x37
(which is used by some EEPROMs as well as the DDC/CI interface.)

While less critical, it might also make sense to remove 0x37 from
normal_i2c[] in the tmp401 driver. Users with a TMP435 as this address
can always instantiate it explicitly.

What do you think?

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

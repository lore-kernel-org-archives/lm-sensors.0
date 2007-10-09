From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 09 Oct 2007 12:03:14 +0000
Subject: [lm-sensors] syfs attributes for signaling powersupply availability
Message-Id: <470B6E02.9070504@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just got some info from Siemens (Thanks Thilo) on howto detect the presence 
of up to 2 power supplies with the fscscy and fscpos IC's and the status (OK or 
fail) of these. So we need to come up with a sysfs interface for this.

I suggest:
powersupplyX_present
powersupplyX_fault

How does that sound?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

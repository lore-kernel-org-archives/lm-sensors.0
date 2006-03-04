From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 04 Mar 2006 12:41:35 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <44098AFF.2060806@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Oh I forgot. The patch needs this patches to work:
hwmon-allow-sensor-attr-arrays.patch  hwmon-convert-semaphores-to-mutexes.patch
w83627ehf_use_new_sensor_device_attr.patch-0001.txt
(get it here http://lists.lm-sensors.org/pipermail/lm-sensors/2006-January/015115.html, first
two are available through jean's homepage)

I'm attaching the userspace part this should work applying on the top of the
latest version of lm-sensors.

regards
Rudolf

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: add_voltages
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060304/b5ac6de8/add_voltages.pl

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 22:27:27 +0000
Subject: [lm-sensors] [PATCH 0/4] adm1031 updates
Message-Id: <20071202232727.5a1d554b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here comes a 4-piece patchset updating the adm1031 driver:
* Fix register overwrite in set_fan_div()
* Various cleanups
* Get rid of macro-generated wrappers
* Add individual alarm and fault files

Alexandre, I would appreciate if you could test these patches. My
ADM1031 evaluation board behaves weirdly so I can't really use it to
test the changes I made to the driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

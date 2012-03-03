From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Mar 2012 21:22:58 +0000
Subject: [lm-sensors] [PATCH 0/3] sensord: Fixes and performance improvements
Message-Id: <20120303222258.3d2c76b0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH 1/3] sensord: Fix memory leaks in sensord revealed by valgrind
[PATCH 2/3] sensord: Fold get_features() into do_features()
[PATCH 3/3] sensord: Avoid strcat

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

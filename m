From: Nikola Pajkovsky <npajkovs@redhat.com>
Date: Mon, 13 Feb 2012 13:37:22 +0000
Subject: [lm-sensors] sensord systemd unit
Message-Id: <m5d39ikg6l.fsf@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- prog/init/sensord.systemd	(revision 0)
+++ prog/init/sensord.systemd	(revision 0)
@@ -0,0 +1,11 @@
+[Unit]
+Description=Sensor Information Logging
+
+[Service]
+Type=forking
+EnvironmentFile=-/etc/sysconfig/sensord
+PIDFile=/run/sensord.pid
+ExecStart=/usr/sbin/sensord -i $INTERVAL -l $LOG_INTERVAL -f daemon
+
+[Install]
+WantedBy=multi-user.target

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

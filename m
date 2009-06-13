From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sat, 13 Jun 2009 17:21:11 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: (abituguru3) DMI probing on more
Message-Id: <1244913674-9633-1-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Jean,

These patches have been compile and runtime tested.

They switch AB9, AB9 QuadGT and IX38 QuadGT mainboards over to using
the DMI probe method. The testers have been credited appropriately.

(The driver currently supports 17 models, 7 are now using DMI.)

--
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

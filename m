From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 06 Oct 2009 11:50:23 +0000
Subject: [lm-sensors] [PATCH 0/2] asus_atk0110: refactor and support for new
Message-Id: <20091006115023.697932717@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,
I'm sending two patches for asus_atk0110:
- the first one is mostly refactoring to allow easier extension of the driver;
  it also extends GITM to handle buffers larger than 8 bytes.
- the second one add support for enabling/disabling EC

Luca


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

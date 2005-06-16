From: atis@mikrotik.com (Atis Elsts)
Date: Thu, 16 Jun 2005 15:58:32 +0000
Subject: [lm-sensors] Ticket 2005
Message-Id: <200506161659.57761.atis@mikrotik.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nevermind about that support ticket. "modprobe lm85 force_emc6d102=1,0x2e" did 
the trick. Perhaps the lm85 driver did not detect my chip correctly.

Atis

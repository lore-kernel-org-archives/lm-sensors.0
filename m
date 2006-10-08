From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 11:36:47 +0000
Subject: [lm-sensors] [PATCH] W83627EHF fix fan5
Message-Id: <20061008133647.a2e7f227.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Following patch fixes the detection of fan5 and preserves the bit between the
> register writes, because the bit is write only.

Applied, thanks. Let's hope nothing will break. I guess people will
report if this change causes trouble to them. Anyway it's about the
only thing we can do to workaround the hardware bug :/

-- 
Jean Delvare


From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: SMSC LPC47M192 SMBus question
Message-Id: <20050413214931.789a60f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <87vf6ua498.wl@wore.ma.cx>
In-Reply-To: <87vf6ua498.wl@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Oh, really? LPC47M15x and LPC47M192 are compatible?

I just checked the datasheet and they definitely are. They better be
anyway, because they have the same identification registers.

I just added detection of these chips to our sensors-detect script.

-- 
Jean Delvare

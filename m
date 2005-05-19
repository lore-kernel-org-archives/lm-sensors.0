From: P@draigBrady.com (P@draigBrady.com)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <4222FE2A.9070803@draigBrady.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BIe4VCVx.1109588428.5008080.khali@localhost>
In-Reply-To: <BIe4VCVx.1109588428.5008080.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: pasik@iki.fi, LM Sensors <sensors@Stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

Jean Delvare wrote:
> I am not familiar with watchdogs. I'd invite you to get in touch with
> the author and/or maintainer of the w83627hf_wdt driver, or possibly try
> to debug it yourself. Datasheets are freely available from Winbond for
> both the W83627HF and W83627THF:
>   http://www.winbond.com/e-winbondhtm/partner/b_2_d_2.htm

He already contacted me (indirectly).
A test program I sent showed the timer in the winbond
counting down, but the reboot never happened.
I would need to get access to the hardware to debug further.

-- 
P?draig Brady - http://www.pixelbeat.org
--

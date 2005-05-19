From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: Small bug fix in mtp008.c
Message-Id: <20040731144744.64c58aa7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040726234302.A25950@alchar.org>
In-Reply-To: <20040726234302.A25950@alchar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here is a small patch that fixes the setting of limits on the temp2
> sensors in the MTP008 chip.  The code (embarassingly written by myself
> when I wrote the MTP008 chip driver a long time ago) would always
> update the hyst and max limits of the first temp sensor, even when you
> tried to set it for the 2nd or 3rd sensors.

Applied (with cosmetic edits), thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Aug 2006 20:58:40 +0000
Subject: [lm-sensors] [PATCH] AMD K8 digital sensor - take3
Message-Id: <20060823225840.af4a6ae4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44EC7391.2040700@sh.cvut.cz>
In-Reply-To: <44EC7391.2040700@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch adds support for the temperature sensor(s) found in AMD K8 CPUs.
> 
> Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>
> 
> I fixed the remaining issues, I got rid of REG_TEMP_T. I left the different 
> register i/o sizes. It is neccessary for future extensions of the driver.
> 
> Please apply.

Applied, thanks.

I'll send a set of hwmon patches to Greg next weed-end, including this
one.

-- 
Jean Delvare


From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: before release, add it8712 line, add warn line [PATCH]
Message-Id: <20040922223503.2f66171b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409221312280.6322@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409221312280.6322@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This patch adds the it8712 line to sensors.conf because I add the
> it8712 "brand" to the driver to allow the vid reading. It will be in
> 2.6.9 kernel.
> 
> Second part adds warning to sensors.h mainly for developers not to add
> legacy SYSCTL entries there because it is generated. I add them there
> for my 2.6 only driver and they gone :/

Applied, thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

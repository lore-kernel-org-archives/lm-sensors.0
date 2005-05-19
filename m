From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: EP-9NDA3+ w/ Winbond W83627THF LPC
Message-Id: <20041217225727.0938408e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
In-Reply-To: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Explanation was: the W83627THF is on secondary Super-I/O address
(0x4e/0x4f), and the driver doesn't support that.

The driver would need to be updated in the same way I did for the
pc87360.

-- 
Jean Delvare
http://khali.linux-fr.org/

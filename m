From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <20040115192605.52660992.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074005072.400404506dd11@imp.gcu.info>
In-Reply-To: <1074005072.400404506dd11@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

And I add:

5# ISA-only chip drivers selection should autodelect i2c-isa. These are
via686a and soon vt1211.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

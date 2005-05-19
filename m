From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: fan speeds and temps no reading
Message-Id: <20050113204220.240796cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
In-Reply-To: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Could you please provide a dump of logical device 8 or your W83627THF
chip?

isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x87
isadump -y 0x2e 0x2f 8 > w83627thf-ld8.dump
isaset -y -f 0x2e 0xaa

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/

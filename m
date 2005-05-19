From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: no isaset in debian
Message-Id: <20041116230249.5155437f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

Looks like you don't include the isaset tool in the debian packages of
lm_sensors. Is it intentional? This tool is useful for investigating
problems on ISA chips or reconfiguring them when the BIOS failed to do
it properly. It's just like i2cset but for the ISA bus. I would suggest
that you include it.

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/

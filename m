From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Important CVS changes
Message-Id: <20041125230447.5ccf3f79.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I just commited the second wave of CVS changes required to be compatible
with Linux 2.4 again. This time this is for i2c_adapter so this is a
much more important change.

lm_sensors-CVS obviously needs i2c-CVS now.

Please test as much as possible, the changes are large but very similar
from file to file, I have good hope it'll work OK. Works well enough for
me at least.

Once this is tested I'll finish the work with the client part (even more
changes).

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/

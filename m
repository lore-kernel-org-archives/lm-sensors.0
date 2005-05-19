From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: Sensors-detect fail to detect devfs (with patch)
Message-Id: <20040508132320.2f5a5b5f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040507084158.GA31429@pc.aurel32.lan>
In-Reply-To: <20040507084158.GA31429@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> When running sensors-detect on a system with devfs enabled, and the 
> /proc/mounts report its device different from 'none' (for example
> devfsd uses 'devfs' as device name), sensors-detect don't detect devfs
> and try to use normal names for i2c devices.
> 
> The attached patch fixes that.

Thanks, applied.

-- 
Jean Delvare
http://khali.linux-fr.org/

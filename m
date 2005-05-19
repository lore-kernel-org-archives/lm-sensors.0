From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: bug report?!
Message-Id: <L0BXzZKE.1091789362.2184150.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1Bt0wR-0002TF-00@intern.SerNet.DE>
In-Reply-To: <E1Bt0wR-0002TF-00@intern.SerNet.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I tried to compile i2c and lm_sensors on this machine:
>
>Linux dhcp230 2.4.21-99-athlon #1 Wed Sep 24 13:34:32 UTC 2003 i686 athlon i386
> GNU/Linux).
>gcc version 3.3.1 (SuSE Linux)
>
>While compilation i get on both i2c and lm_sensors the following error:
>
>kernel/i2c-pport.c:154: error: initializer element is not constant
>kernel/i2c-pport.c:154: error: (near initialization for `bit_pport_data.timeout'

Suse hacked their kernel tree in a way which makes it incompatible with
our sources. Several users already reported about that.

We do not support that. Either complain to Suse, or use their packages
for lm_sensors (if such packages exist) or use a vanilla kernel instead
of a Suse one. Our packages are tested to work perfectly with vanilla
kernels.

Jean Delvare

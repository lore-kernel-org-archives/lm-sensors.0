From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: linux/i2c-dev.h conflict between i2c-2.8.0 and lm_sensors-2.8.0
Message-Id: <20030728204044.7a469123.vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

With i2c-2.8.0 and lm_sensors-2.8.0 there is a conflict on the
<linux/i2c-dev.h> header. i2c (when compiled using the option 3 -
patched into the kernel) installs its i2c-dev.h into the kernel
includes; lm_sensors installs its i2c-dev.h into /usr/include/linux -
which may be the same, depending on the symlinks configuration.

I see that i2c-dev.h in the i2c package was cleaned and contains no
userspace parts, and i2c-dev.h from the lm_sensors package is the
userspace header. Maybe this userspace header should be installed in
some other place - e.g., into $(LIBINCLUDEDIR)?

-- 
Sergey Vlasov

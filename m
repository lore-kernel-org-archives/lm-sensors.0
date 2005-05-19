From: delvare@free.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: modprobe piix4 does not return
Message-Id: <20030110205212.617a6045.delvare@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <15076.1042157201@www40.gmx.net>
In-Reply-To: <15076.1042157201@www40.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have Linux 2.2.16 running on a Asus Tx97e board. I had several
> problems with the i2c package. 
> 
> First, I downloaded the new i2c package i2c-2.7.0.tar.gz. I realized,
> that it does not contain the i2c-piix4.o module. Is that what the
> developers intended?
> Then, I downloaded the lm_sensors-2.7.0.tar.gz package, which contains
> the i2c-piix4.c source code. This time, I had problems with the
> compilation of the package:
> 
> ------
> kernel/chips/lm92.c:96: warning: parameter names (without types) in
> function deckernel/chips/lm92.c: In function `lm92_temp':
> kernel/chips/lm92.c:180: `mutex' undeclared (first use in this
> function) kernel/chips/lm92.c:180: (Each undeclared identifier is
> reported only once kernel/chips/lm92.c:180: for each function it
> appears in.) kernel/chips/lm92.c: In function `lm92_alarms':
> kernel/chips/lm92.c:207: `mutex' undeclared (first use in this
> function) kernel/chips/lm92.c: In function `lm92_detect':
> kernel/chips/lm92.c:280: `mutex' undeclared (first use in this
> function) kernel/chips/lm92.c:298: `THIS_MODULE' undeclared (first use
> in this function)  
> ------
> which I solved by copying the definitin of DECLARE_MUTEX and
> THIS_MODULE from der modules.

2.7.0 hasn't been tested on kernels that old. I tested on 2.2.20 and
later and it was fine. So, either upgrade your kernel, or use an older
version of i2c/lm_sensors. 2.6.3 should work fine on a TX97-E.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

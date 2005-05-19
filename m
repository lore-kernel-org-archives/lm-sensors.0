From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c i2c-pport.c
Message-Id: <Pine.OSF.4.50.0301141313380.11865-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23647B.2070805@paradyne.com>
In-Reply-To: <3E23647B.2070805@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Jan 2003, Mark Studebaker wrote:

<clip>
> kernel/i2c-pcf-epp.c:223: initializer element is not computable at load time
> kernel/i2c-pcf-epp.c:223: (near initialization for `pcf_epp_ops.name[6]')
> make: *** [kernel/i2c-pcf-epp.o] Error 1
>
> Also, should be do C99 initializers before the branch?

Well most were already applied in 2.5 tree. I'll port them back to 2.4
once the rest get caught.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

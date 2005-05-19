From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: no sensors found! with 2.6.0 kernel
Message-Id: <20040109231822.6fa1f4fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109220819.F0E2E3945@sitemail.everyone.net>
In-Reply-To: <20040109220819.F0E2E3945@sitemail.everyone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> hello - thank you for the great lm_sensors program. i've been using it
> with great success until kernel 2.6.0, but now i am having a problem i
> can't figure out. i don't know whether to file a bug report or what
> the problem might be, so i figured i would ask here first. 
> 
> Driver `w83781d' (may not be inserted):
>   Misdetects:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF' (confidence: 8)
> 
> Driver `w83627hf' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)
> 
> i think that misdetected Driver (w83781d) must be the problem. it was
> detected in prior kernels, but now it can't be loaded for some reason.

1* Yes, the w83627hf driver has not been ported to kernel 2.6 yet, so
you have to use w83781d instead.

2* The detection problem in w83781d is supposed to be fixed in kernel
2.6.1. If it isn't, let us know.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

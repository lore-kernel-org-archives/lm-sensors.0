From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: bug
Message-Id: <20030630110902.22cc0849.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
In-Reply-To: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> ses/i2c-ali15x3.c -o kernel/busses/i2c-ali15x3.o
> gcc  -DMODVERSIONS -include
> /lib/modules/2.4.21/build/include/linux/modversions. h -D__KERNEL__
> -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/includ e
> -I/usr/local/include -I/lib/modules/2.4.21/build/include   -O2   -c
> kernel/bus ses/i2c-amd756.c -o kernel/busses/i2c-amd756.o
> gcc  -DMODVERSIONS -include
> /lib/modules/2.4.21/build/include/linux/modversions. h -D__KERNEL__
> -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/includ e
> -I/usr/local/include -I/lib/modules/2.4.21/build/include   -O2   -c
> kernel/bus ses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
> kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old -
> i2c-2.7.0 or grea ter required!

Well, I think the error message is explicit. You need to upgrade i2c to
2.7.0.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

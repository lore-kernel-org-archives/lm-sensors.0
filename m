From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: bug
Message-Id: <000501c33eef$b4353e80$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
In-Reply-To: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You can install i2c from our i2c-2.7.0 package. It doesn't require to
> patch the kernel. Just make sure you don't have any I2C module built
> into the kernel itself, and install all the modules from our package
> (make && make install && depmod -ae should just do it).


        i compiled & instaled i2c-2.7.0 and when doing 'make' in lm-sensors
shows the same error:









h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/in
clud
e -I/usr/local/include -I/lib/modules/2.4.21/build/include   -O2   -c
kernel/bus
ses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old - i2c-2.7.0 or
grea
ter required!
kernel/busses/i2c-amd8111.c: En la funci?n `amd8111_access':
kernel/busses/i2c-amd8111.c:238: `I2C_CLIENT_PEC' no ha sido declarado aqu?
(pri
mero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:238: (Cada identificador no declarado solamente
se r
eporta una vez
kernel/busses/i2c-amd8111.c:238: para cada funcion en la que aparece.)
kernel/busses/i2c-amd8111.c:298: `I2C_SMBUS_BLOCK_PROC_CALL' no ha sido
declarad
o aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:309: `I2C_SMBUS_WORD_DATA_PEC' no ha sido
declarado
aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:310: `I2C_SMBUS_BLOCK_DATA_PEC' no ha sido
declarado
 aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:311: `I2C_SMBUS_PROC_CALL_PEC' no ha sido
declarado
aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:312: `I2C_SMBUS_BLOCK_PROC_CALL_PEC' no ha sido
decl
arado aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c: En la funci?n `amd8111_func':
kernel/busses/i2c-amd8111.c:385: `I2C_FUNC_SMBUS_BLOCK_PROC_CALL' no ha sido
dec
larado aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:386: `I2C_FUNC_SMBUS_HWPEC_CALC' no ha sido
declarad
o aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c: En la funci?n `amd8111_probe':
kernel/busses/i2c-amd8111.c:426: `I2C_HW_SMBUS_AMD8111' no ha sido declarado
aqu
? (primero ?selo en esta funci?n)
make: *** [kernel/busses/i2c-amd8111.o] Error 1

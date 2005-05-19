From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: bug
Message-Id: <000801c33ee6$a1ed75c0$f265a8c0@gf01>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ses/i2c-ali15x3.c -o kernel/busses/i2c-ali15x3.o
gcc  -DMODVERSIONS -include /lib/modules/2.4.21/build/include/linux/modversions.
h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/includ
e -I/usr/local/include -I/lib/modules/2.4.21/build/include   -O2   -c kernel/bus
ses/i2c-amd756.c -o kernel/busses/i2c-amd756.o
gcc  -DMODVERSIONS -include /lib/modules/2.4.21/build/include/linux/modversions.
h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/includ
e -I/usr/local/include -I/lib/modules/2.4.21/build/include   -O2   -c kernel/bus
ses/i2c-amd8111.c -o kernel/busses/i2c-amd8111.o
kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old - i2c-2.7.0 or grea
ter required!
kernel/busses/i2c-amd8111.c: En la funci?n `amd8111_access':
kernel/busses/i2c-amd8111.c:238: `I2C_CLIENT_PEC' no ha sido declarado aqu? (pri
mero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:238: (Cada identificador no declarado solamente se r
eporta una vez
kernel/busses/i2c-amd8111.c:238: para cada funcion en la que aparece.)
kernel/busses/i2c-amd8111.c:298: `I2C_SMBUS_BLOCK_PROC_CALL' no ha sido declarad
o aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:309: `I2C_SMBUS_WORD_DATA_PEC' no ha sido declarado
aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:310: `I2C_SMBUS_BLOCK_DATA_PEC' no ha sido declarado
 aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:311: `I2C_SMBUS_PROC_CALL_PEC' no ha sido declarado
aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:312: `I2C_SMBUS_BLOCK_PROC_CALL_PEC' no ha sido decl
arado aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c: En la funci?n `amd8111_func':
kernel/busses/i2c-amd8111.c:385: `I2C_FUNC_SMBUS_BLOCK_PROC_CALL' no ha sido dec
larado aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c:386: `I2C_FUNC_SMBUS_HWPEC_CALC' no ha sido declarad
o aqu? (primero ?selo en esta funci?n)
kernel/busses/i2c-amd8111.c: En la funci?n `amd8111_probe':
kernel/busses/i2c-amd8111.c:426: `I2C_HW_SMBUS_AMD8111' no ha sido declarado aqu
? (primero ?selo en esta funci?n)
make: *** [kernel/busses/i2c-amd8111.o] Error 1
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030630/ec968927/attachment.html

From: rod@morison.biz (Rod Morison)
Date: Thu, 25 May 2006 06:57:36 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <44755560.2030009@morison.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hello,
>
> I remember I did some patch for 2.6 kernel for this.
>
> Maybe it is missing for 2.4?
>   
I'm building 2.10.0 for the 2.4 kernel from source. For 2.6 kernel I'm 
using the Suse supplied build (opensuse 10.1 distro).
> Anyway please supply output of following:
>
> modprobe i2c-dev
> i2cdetect 0
> i2cdump 0 0x2f
>
>   
Here's the output:

ImageServer#/tmp: ./i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          XX XX XX XX XX 08 XX XX XX 0c XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX 2f
30: 30 XX 32 XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX 48 49 XX XX XX XX XX XX
50: UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX
60: 60 61 62 63 64 XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX                        
ImageServer#/tmp: ./i2cdump 0 0x2f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2f, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ??..............
10: 00 00 64 64 b2 00 00 38 00 ff 00 00 05 00 e0 b3    ..dd?..8....?.??
20: ab c0 cd bd 1f c4 d1 22 18 ff 19 d2 82 ce a9 e2    ???????"?.??????
30: b9 ce a8 2f 13 d9 b1 cc a7 32 00 ed ed ed 39 bf    ???/?????2.???9?
40: 03 00 20 57 7f ff ff 33 2f 13 88 c0 45 ff 80 5c    ?. W?..3/???E.?\
50: ff ff ff ff ff ff ff ff 7a 20 ff 33 33 01 05 7f    ........z .33???
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 8f ff 8f 00 00 00 50 11 ff ff ff 3c 00 0a 0a    ??.?...P?...<.??
90: 00 00 00 01 8f ff 00 00 11 ff 3c 00 bf 01 01 ff    ...??...?.<.???.
a0: 01 01 01 8f 8f 8f 8f ff 37 40 30 a0 ff ff 00 00    ???????.7 at 0?....
b0: cb cb ff ff cc a7 e2 b9 ff 1e ff ed ed ed 41 ff    ??..????.?.???A.
c0: 2c 80 00 4b 00 50 00 ff 1e 80 00 4b 00 50 00 ff    ,?.K.P..??.K.P..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b ff 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ?.?(<P(<P(<P....
f0: ff ff 80 ff 00 05 00 7f ff 02 ff 00 00 00 00 ff    ..?..?.?.?......
ImageServer#/tmp: lsmod
Module                  Size  Used by    Tainted: P 
w83627hf               14104   0  (unused)
w83792d                11988   0  (unused)
w83781d                19196   0  (unused)
i2c-isa                  804   0  (unused)
i2c-i801                4828   0
eeprom                  3500   0  (unused)
i2c-proc                5988   0  [w83627hf w83792d w83781d eeprom]
i2c-dev                 3776   0
i2c-core               14276   0  [w83627hf w83792d w83781d i2c-isa 
i2c-i801 eeprom i2c-proc i2c-dev]
vrdvx                  51460   4
vrdsp                1234848   2
vrsfd                  74096  14  [vrdvx vrdsp]
vrmem                   9760   2
e1000                  98896   1
ImageServer#/tmp:


> This means that there was some misprogramming done by BIOS which put two other
> sublients to same addr. The subclients are legacy LM75 like chips emulated by
> w83792d.
>
>   
But why would 2.6 distro work and 2.4 not work for w83792d-i2c-0-2f if 
it was a BIOS problem?
> Please let me know if
> modprobe w83792d force_subclients=0,0x2f,0x4a,0x4b
>
>   
Nope, still didn't get w83792d-i2c-0-2f to appear. Thanks for the help!





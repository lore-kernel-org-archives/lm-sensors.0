From: RusH <citizenr@gmail.com>
Date: Mon, 02 Apr 2007 00:22:54 +0000
Subject: Re: [lm-sensors] Asus smbus mux
Message-Id: <3df49b7b0704011722q1201063eh37253910ddb1e004@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/1/07, koko <citizenr@gmail.com> wrote:

rasz@capek:~$ sudo isadump -f 0xe440 16
0 1 2 3 4 5 6 7 8 9 a b c d e f
e440: 10 00 00 00 71 00 00 00 fd 02 c0 00 ff f6 ff 0f
rasz@capek:~$ sudo i2cdetect -y 0 |grep 50
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

bit 0 0xe44d
rasz@capek:~$ sudo isaset -y -f 0xe44d 0xf7
rasz@capek:~$ sudo i2cdetect -y 0 |grep 50
50: 50 51 52 XX XX XX XX XX XX XX XX XX XX XX XX XX

spd works :)
Big thanks to Tamas MIKLOS (Lavalys) and Franck@x86 (x86-secret)

Tamas MIKLOS send me the asus mux code. There are 5 hacks with smbus
mux switch on IO, and 3 with smbus mux switch on smbus (lol thats
funny), it covers 31 types of asus boards (plus many more subtypes).
Oldest board is P3B, newest P4B.

-- 
Who logs in to gdm? Not I, said the duck.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: koko <citizenr@gmail.com>
Date: Sun, 01 Apr 2007 17:25:23 +0000
Subject: Re: [lm-sensors] repost: read the spd on A7V133 | without UTF-8
Message-Id: <3df49b7b0704011025n397b164boc2d8c714c86ed9e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3df49b7b0703311542l79ea2595pcfd8546aab4b07ac@mail.gmail.com>
In-Reply-To: <3df49b7b0703311542l79ea2595pcfd8546aab4b07ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>blabal

ok, I found old topics about Asus IO mux
ten I found SPDINFO.EXE

E:\dane\Testery !\sandra>SPDINFO.EXE 1 a7v
Ctrl 0, SMBus, Sys, IO 0000e800h, Mem 00000000h, Drv Intel PIIX4 SMBus / compati
ble, Brd A7V
Mux 0 Asus IO mux, IO 0000e44dh, Ext 4267320

then I found posts about isaset hack, then about i2c-virtual, then I
found out that its all abandoned :( blah

Are there any recent boards that require i2c-virtual?

-- 
Who logs in to gdm? Not I, said the duck.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

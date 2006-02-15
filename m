From: vr@aradio.ru (Victor A. Bykov)
Date: Wed, 15 Feb 2006 12:02:18 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <052801c63227$aba4b790$5964a8c0@office.aradio.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
In-Reply-To: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"?????????"
????:  lm-sensors at lm-sensors.org
       Jean Delvare
??: ????????? ????????????? ????? ?????? ?????????
????: Re: [lm-sensors] w83781d and empty /sys/class/hwmon

>> but there is simlink to device in /sys/class/i2c-dev/i2c-0
>This means that the bus driver (i2c-piix4) works. This doesn't mean that
>any device on that bus was properly recognized.
>> > Does "sensors" (without -s) work?
>>
>> no, it does not (strace shows it tries to read /sys/class/hwmon and exits
>> with error)
>This is expected if the hardware monitoring device wasn't properly
>detected.

>Which version of lm_sensors are you using?
sensors version 2.10.0 with libsensors version 2.10.0

>Which motherboard is this?
sorry, I can't look right now, some kind of asus....

>Any message in the logs when loading the w83781d driver?
Nothing!

>Pleas provide the output of:
>  i2cdump 0 0x2d b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: b2 c2 9e 61 c1 d0 00 cc a7 f7 a4 ab 8c 67 54 f7    ???a??.??????gT?
10: a4 f7 a4 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
20: 67 9e db b5 c3 b5 ce 26 47 ff ff 73 5b ab 8c e2    g??????&G..s[???
30: b9 cc a7 e0 96 e2 97 f9 a6 69 00 ff ff ff 00 00    ?????????i......
40: 01 00 00 ff 00 00 00 a8 00 20 01 80 31 80 80 12    ?......?. ??1???
50: 00 00 00 00 00 00 ff ff 31 8f 8f 0c e0 48 e2 7f    ........1????H??
60: 67 9e db b5 c3 b5 c7 26 47 ff ff 73 5b ab 8c e2    g??????&G..s[???
70: b9 cc a7 e0 96 e2 97 f9 a6 69 00 ff ff ff 00 00    ?????????i......
80: b2 c2 9e 61 c1 d0 00 cc a7 f7 a4 ab 8c 67 54 f7    ???a??.??????gT?
90: a4 f7 a4 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
a0: 67 9e db b5 c3 b5 c7 26 47 ff ff 73 5b ab 8c e2    g??????&G..s[???
b0: b9 cc a7 e0 96 e2 97 f9 a6 69 00 ff ff ff 00 00    ?????????i......
c0: b2 c5 9e 61 c1 d0 00 cc a7 f7 a4 ab 8c 67 54 f7    ???a??.??????gT?
d0: a4 f7 a4 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
e0: 67 9e db b5 c3 b5 c7 26 47 ff ff 73 5b ab 8c e2    g??????&G..s[???
f0: b9 cc a7 e0 96 e2 97 f9 a6 69 00 ff ff ff 00 00    ?????????i......




????/?????: 15.02.2006 15:02:20
???????: + 7 (495) 258-33-44
E-mail: vr at aradio.ru
??? ????: http://www.avtoradio.ru


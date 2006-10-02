From: hans.edgington@xs4all.nl (Hans Edgington)
Date: Mon, 02 Oct 2006 20:46:29 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <001401c6e663$dbcfd760$1f140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have been trying to find what some of the other fields mean this is what I
have found out so far.

The f8 and f9 seem to contain the temperature at which the system shuts
down.
5d-5e are the fintek ID, discovered by Jean.

Tried to find the fields for fan control and found the following:
When setting the fan control, was disabled the field 96 a3-a5 a7-a9 and
ab-ae changed. A3 and ab contain the same value, which I set in the bios,
and is the percentage of max rpm at which the cpu fan can operate. Seems
that the fields a4 and a5 are the max rpm of the fan a4 is the MSB and a5
LSB. The fields get updated when a higher rpm is detected.
Ab is  fast fan speed percnatge of max, ac field is the half fan speed, ad
and ae are the lowest fanspeed setting which I can't change but are 30% of
max.
A6, a7 and a8 are the temperatures at which the fanspeed will increase.

Haven't found out why field 96 changed maybe to say that fan temps and
speeds have been set?

Below are two isadumps which I used two discover the changes, first one
before setting fan control second is after.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff 03 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
10: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
20: d3 af ab 83 7a 8a 76 d6 c3 ff ff ff ff ff ff ff 
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff 03 04 10 19 34 ff 
60: 00 00 00 00 ff ff 02 74 00 00 ff 06 40 24 ff 00 
70: ff ff 2e ff 1f ff 00 ff ff ff ff ff ff ff ff ff 
80: ff ff 65 64 64 55 55 46 ff ff ff ff ff ff a8 ff 
90: 00 0c 0c 00 15 ff 57 ff 44 22 ff aa 55 55 ff 0a 
a0: 01 d5 00 ff 02 23 3c 32 28 1e ff d9 b2 99 80 01 
b0: 02 31 00 99 02 1b 3c 32 28 1e ff d9 b2 99 80 02 
c0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 
d0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 00 00 00 00 00 00 37 ff 22 ff ff 02 ff ff ff ff

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff 03 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
10: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
20: d3 af ab 84 7a 8a 76 d6 c7 ff ff ff ff ff ff ff 
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff 03 04 10 19 34 ff 
60: 00 00 00 00 ff ff 02 74 00 00 ff 06 40 24 ff 00 
70: ff ff 30 ff 1e ff 00 ff ff ff ff ff ff ff ff ff 
80: ff ff 65 64 64 55 55 46 ff ff ff ff ff ff a8 ff 
90: 00 0c 0c 00 15 ff 55 ff 44 22 ff aa 55 55 ff 0a 
a0: 02 31 00 cc 01 bf 3c 28 14 0a ff cc 7f 4a 4a 01 
b0: 02 1b 00 99 02 1b 3c 32 28 1e ff d9 b2 99 80 02 
c0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 
d0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 00 00 00 00 00 00 37 ff 02 ff ff 02 ff ff ff ff

Hans Edgington



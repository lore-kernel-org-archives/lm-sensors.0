From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Sun, 26 Jan 2014 15:58:06 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <52E5308E.7020806@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Guenter

On 24.01.2014 15:40, Guenter Roeck wrote:
> One interesting experiment might be to check what happens if you
> set pwm2_auto_point1_pwm to a value between 1 and 4. If that
> results in the fan running at full speed, we have some indication
> that either the fan or the board hardware is causing this
> behavior.
Same result. If the calculated pwm value (pwm2) is smaller than 5, the
fan spins up to maximum rpm.

Today I disassembled my other pc (on which I'm able to completely stop
the fan by reducing the pwm value) with the same model of CPU fan
(Arctic Freezer 13) and hooked it up to the ASUS H87-PRO. The fan
looks a little bit different than the other, but the values are almost
the same.

Arctic Cooling Freezer 13 (Old Model)
- -------------------------------------

pwm2	rpm
1	2064
2	2064
3	2064
4	2064
5	393
6	272
7	398
8	187
9	196
10	423
11	493
20	486
30	630
40	730
50	912
60	1060
70	633
90	859
128	1251
255	2261

Almost the same result with the original fan

Arctic Cooling Freezer 13 (New Model)
- -------------------------------------

pwm2	rpm
1	2257
2	2253
3	2261
4	2180
5	551
6	451
7	407
8	370
9	366
10	370
11	392
12	411
13	433
60	1203
70	1355
90	1580
128	1836
255	2260

Then I took the boxed Intel fan and hooked it to the ASUS Board.

Intel Boxed Cooler
- ------------------

pwm2	rpm
1	976
2	974
3	972
4	976
5	978
6	972
7	975
8	973
9	973
58	976
59	1005
60	1018
61	1021
70	1072
90	1184
128	1393
255	1953

And now the interesting part ;-) Connected the original fan to
CHA_FAN2 (controlled by pwm3)

Arctic Cooling Freezer 13 (New Model)
- -------------------------------------

pwm3	rpm
1	0
2	0
3	0
4	0
5	0
6	0
50	0
55	430
60	512
70	633
90	859
128	1251
255	2261

On this pwm3 output I'm able to let the fan spin down until it stops
(around pwm 50-55)

So it seems that the CPU fan output is somehow special - but I guess
only ASUS knows how exactly and why.
- -- 
greetings
 Mathias

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLlMI4ACgkQnfTEjDUZ2fOXxgCfeIyv7NXNZLm4gHc9a+bFEF/0
cnkAnAvThiVg2teiDw5mXxelg+gfNeR9
+kY
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

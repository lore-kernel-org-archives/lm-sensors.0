From: camden lindsay <camden.lindsay+lmsensors@gmail.com>
Date: Thu, 25 Oct 2012 01:40:33 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <CABkW7JMktGc9a4ROYCHqG2_+bOQofq7JwUDbEsjDNuERqoCjSw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0006515408093384284=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0006515408093384284==
Content-Type: multipart/alternative; boundary=e89a8fb206d43448a104ccd84b5a

--e89a8fb206d43448a104ccd84b5a
Content-Type: text/plain; charset=ISO-8859-1

>
> Hi,
>
> Please don't top-post.
>
> If you set anything but full speed mode, do you see different pwm values ?
>
> Also, please provide the output of
>
>         sudo isadump -y 0x295 0x296 0
>         sudo isadump -y 0x295 0x296 8
>         sudo isadump -y 0x295 0x296 9
>         sudo isadump -y 0x295 0x296 10
>         sudo isadump -y 0x295 0x296 11
>
> Thanks,
> Guenter
>
>
Sorry about the top-post, its a habit from working for years in gmail and
never really taking part in mailing lists;  I really don't know the correct
mannerisms.

Yes, pwm{1..3} change depending on the fan mode set in bios.
Out of curiosity, is there a datasheet for the chip floating around?  It
seems the manufacturer makes it on-request-only.  I couldn't find it online
anywhere particularly easily... lots of bad results in a search.


Hopefully this isn't too much to parse, but i've provided the
/sys/bus/hwmon and the isadump  output for each of the fan settings  in bios

Thanks!
Camden

"Full speed mode"--------------------------------------------------
pwm1    255
pwm1_enable    1
pwm1_max_output    255
pwm1_mode    0
pwm1_start_output    1
pwm1_step_output    1
pwm1_stop_output    1
pwm1_stop_time    24000
pwm1_target    0
pwm1_tolerance    0

pwm2    255
pwm2_enable    2
pwm2_max_output    255
pwm2_mode    1
pwm2_start_output    1
pwm2_step_output    1
pwm2_stop_output    128
pwm2_stop_time    6000
pwm2_target    0
pwm2_tolerance    2000

pwm3    255
pwm3_enable    1
pwm3_max_output    255
pwm3_mode    1
pwm3_start_output    1
pwm3_step_output    1
pwm3_stop_output    1
pwm3_stop_time    6000
pwm3_target    0
pwm3_tolerance    4000

0x295 0x296 0 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c4
20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3
50: ff ff 00 ff ff ff 00 00 c1 c7 ff ff 01 01 00 05
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
90: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3
d0: ff ff 00 ff ff ff 00 00 c1 c7 ff ff 01 01 00 05
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 8 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
50: 00 ff ff ff 00 10 02 c8 ff 06 ff ff 08 ff ff 14
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
90: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
d0: 00 ff ff ff 00 10 02 c8 ff 06 ff ff 08 ff ff 14
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 9 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3
50: 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
90: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3
d0: 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 10 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3
50: 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
90: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3
d0: 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 11 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3
50: 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
90: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c8
a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3
d0: 01 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00



"High Density Mode"--------------------------------------------------
pwm1    63
pwm1_enable    1
pwm1_max_output    255
pwm1_mode    0
pwm1_start_output    1
pwm1_step_output    1
pwm1_stop_output    1
pwm1_stop_time    24000
pwm1_target    30000
pwm1_tolerance    0

pwm2    63
pwm2_enable    2
pwm2_max_output    255
pwm2_mode    1
pwm2_start_output    1
pwm2_step_output    1
pwm2_stop_output    128
pwm2_stop_time    6000
pwm2_target    127000
pwm2_tolerance    2000

pwm3    63
pwm3_enable    1
pwm3_max_output    255
pwm3_mode    1
pwm3_start_output    1
pwm3_step_output    1
pwm3_stop_output    1
pwm3_stop_time    6000
pwm3_target    30000
pwm3_tolerance    4000

0x295 0x296 0 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c6
20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
40: 01 00 00 ff ff 38 3f f5 2d 04 80 c0 10 95 00 a3
50: ff ff 00 ff ff ff 00 00 c1 cf ff ff 01 01 00 05
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c6
a0: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3
d0: ff ff 00 ff ff ff 00 00 c1 cf ff ff 01 01 00 05
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 8 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c6
20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
50: 00 ff ff ff 00 10 02 c8 3f 05 80 3f 06 ff 3f 16
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c6
a0: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
d0: 00 ff ff ff 00 10 02 c8 3f 05 80 3f 06 ff 3f 16
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 9 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8
20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3
50: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff 3f 3f 3f
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8
a0: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3
d0: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff 3f 3f 3f
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 10 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8
20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3
50: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff ff ff ff
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8
a0: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3
d0: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff ff ff ff
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 11 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8
20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3
50: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff 3f 3f 3f
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8
a0: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3
d0: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff 3f 3f 3f
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00



"Generic Mode"--------------------------------------------------
pwm1    51
pwm1_enable    1
pwm1_max_output    255
pwm1_mode    0
pwm1_start_output    1
pwm1_step_output    1
pwm1_stop_output    1
pwm1_stop_time    24000
pwm1_target    30000
pwm1_tolerance    0

pwm2    51
pwm2_enable    2
pwm2_max_output    255
pwm2_mode    1
pwm2_start_output    1
pwm2_step_output    1
pwm2_stop_output    128
pwm2_stop_time    6000
pwm2_target    127000
pwm2_tolerance    2000

pwm3    51
pwm3_enable    1
pwm3_max_output    255
pwm3_mode    1
pwm3_start_output    1
pwm3_step_output    1
pwm3_stop_output    1
pwm3_stop_time    6000
pwm3_target    30000
pwm3_tolerance    4000

0x295 0x296 0 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff dc
20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3
50: ff ff 00 ff ff ff 00 00 c1 cf ff ff 01 01 00 05
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff dc
a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3
d0: ff ff 00 ff ff ff 00 00 c1 cf ff ff 01 01 00 05
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 8 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff dc
20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
50: 00 ff ff ff 00 10 02 c8 33 06 7f 33 08 ff 33 16
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff dc
a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
d0: 00 ff ff ff 00 10 02 c8 33 06 7f 33 08 ff 33 16
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 9 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0
20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3
50: 01 1e 3c 4c ff ff ff 33 80 ff ff ff ff 33 33 33
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0
a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3
d0: 01 1e 3c 4c ff ff ff 33 80 ff ff ff ff 33 33 33
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 10 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0
20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3
50: 01 1e 3c 4c ff ff ff 33 80 ff ff ff ff ff ff ff
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0
a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3
d0: 01 1e 3c 4c ff ff ff 33 80 ff ff ff ff ff ff ff
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00

 0x295 0x296 11 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0
20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3
50: 01 1e 3c 4c ff ff ff 33 80 ff ff ff ff 33 33 33
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
80: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0
a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62
c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3
d0: 01 1e 3c 4c ff ff ff 33 80 ff ff ff ff 33 33 33
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00



"Whisper Mode"--------------------------------------------------
pwm1    0
pwm1_enable    1
pwm1_max_output    255
pwm1_mode    0
pwm1_start_output    1
pwm1_step_output    1
pwm1_stop_output    1
pwm1_stop_time    24000
pwm1_target    30000
pwm1_tolerance    0

pwm2    0
pwm2_enable    2
pwm2_max_output    255
pwm2_mode    1
pwm2_start_output    1
pwm2_step_output    1
pwm2_stop_output    128
pwm2_stop_time    6000
pwm2_target    127000
pwm2_tolerance    2000

pwm3    63
pwm3_enable    1
pwm3_max_output    255
pwm3_mode    1
pwm3_start_output    1
pwm3_step_output    1
pwm3_stop_output    1
pwm3_stop_time    6000
pwm3_target    30000
pwm3_tolerance    4000

0x295 0x296 0 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8
20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
40: 01 40 00 ff ff 00 3f c5 2d 04 80 00 90 95 00 a3
50: ff ff 00 ff ff ff 00 00 c1 c0 ff ff 01 a1 00 05
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8
a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
c0: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 00 a3
d0: ff ff 00 ff ff ff 00 00 c1 c0 ff ff 01 a1 00 05
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 8 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8
20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
40: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 08 a3
50: 00 ff ff ff 00 10 02 c8 00 09 7f 00 0a ff 3f 16
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8
a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
c0: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 08 a3
d0: 00 ff ff ff 00 10 02 c8 00 09 7f 00 0a ff 3f 16
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 9 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8
20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
40: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 09 a3
50: 01 1e 3c 4c ff ff ff 00 19 ff ff ff ff 00 00 3f
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da
a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
c0: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 09 a3
d0: 01 1e 3c 4c ff ff ff 00 19 ff ff ff ff 00 00 3f
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 10 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da
20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
40: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 0a a3
50: 01 1e 3c 4c ff ff ff 00 19 ff ff ff ff ff ff ff
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da
a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
c0: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 0a a3
d0: 01 1e 3c 4c ff ff ff 00 19 ff ff ff ff ff ff ff
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

 0x295 0x296 11 _______________________________
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da
20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
30: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
40: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 0b a3
50: 01 1e 3c 4c ff ff ff 00 19 ff ff ff ff 00 00 3f
60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00
80: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01
90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da
a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3
b0: ba e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff
c0: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 0b a3
d0: 01 1e 3c 4c ff ff ff 00 19 ff ff ff ff 00 00 3f
e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00

--e89a8fb206d43448a104ccd84b5a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
Please don&#39;t top-post.<br>
<br>
If you set anything but full speed mode, do you see different pwm values ?<=
br>
<br>
Also, please provide the output of<br>
<br>
=A0 =A0 =A0 =A0 sudo isadump -y 0x295 0x296 0<br>
=A0 =A0 =A0 =A0 sudo isadump -y 0x295 0x296 8<br>
=A0 =A0 =A0 =A0 sudo isadump -y 0x295 0x296 9<br>
=A0 =A0 =A0 =A0 sudo isadump -y 0x295 0x296 10<br>
=A0 =A0 =A0 =A0 sudo isadump -y 0x295 0x296 11<br>
<br>
Thanks,<br>
Guenter<br>
<div><div><br></div></div></blockquote><div><br></div><div>Sorry about the =
top-post, its a habit from working for years in gmail and never really taki=
ng part in mailing lists; =A0I really don&#39;t know the correct mannerisms=
.</div>


<div><br></div><div>Yes, pwm{1..3} change depending on the fan mode set in =
bios. =A0=A0</div><div>Out of=A0curiosity, is there a datasheet for the chi=
p floating around? =A0It seems the manufacturer makes it on-request-only. =
=A0I couldn&#39;t find it online anywhere particularly easily... lots of ba=
d results in a search.</div>

<div><br></div><div><br></div><div>Hopefully this isn&#39;t too much to par=
se, but i&#39;ve provided the /sys/bus/hwmon and the isadump =A0output for =
each of the fan settings =A0in bios</div><div><br></div><div>Thanks!</div>
<div>
Camden</div><div><br></div><div>&quot;Full speed mode&quot;----------------=
----------------------------------</div><div><div>pwm1 =A0 =A0255</div><div=
>pwm1_enable =A0 =A01</div><div>pwm1_max_output =A0 =A0255</div><div>pwm1_m=
ode =A0 =A00</div>

<div>pwm1_start_output =A0 =A01</div><div>pwm1_step_output =A0 =A01</div><d=
iv>pwm1_stop_output =A0 =A01</div><div>pwm1_stop_time =A0 =A024000</div><di=
v>pwm1_target =A0 =A00</div><div>pwm1_tolerance =A0 =A00</div><div><br></di=
v><div>pwm2 =A0 =A0255</div>

<div>pwm2_enable =A0 =A02</div><div>pwm2_max_output =A0 =A0255</div><div>pw=
m2_mode =A0 =A01</div><div>pwm2_start_output =A0 =A01</div><div>pwm2_step_o=
utput =A0 =A01</div><div>pwm2_stop_output =A0 =A0128</div><div>pwm2_stop_ti=
me =A0 =A06000</div><div>

pwm2_target =A0 =A00</div><div>pwm2_tolerance =A0 =A02000</div><div><br></d=
iv><div>pwm3 =A0 =A0255</div><div>pwm3_enable =A0 =A01</div><div>pwm3_max_o=
utput =A0 =A0255</div><div>pwm3_mode =A0 =A01</div><div>pwm3_start_output =
=A0 =A01</div><div>pwm3_step_output =A0 =A01</div>

<div>pwm3_stop_output =A0 =A01</div><div>pwm3_stop_time =A0 =A06000</div><d=
iv>pwm3_target =A0 =A00</div><div>pwm3_tolerance =A0 =A04000</div><div><br>=
</div><div>0x295 0x296 0 _______________________________</div><div>=A0 =A0 =
=A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =A0e =
=A0f</div>

<div>00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>10: 0=
4 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c4=A0</div><div>20: 74 d8 d3 d3=
 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 2f=A0</div>

<div>40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3=A0</div><div>50: f=
f ff 00 ff ff ff 00 00 c1 c7 ff ff 01 01 00 05=A0</div><div>60: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div>80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 0=
4 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6=A0</div><div>a0: 74 d8 d3 d3=
 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 2f=A0</div>

<div>c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3=A0</div><div>d0: f=
f ff 00 ff ff ff 00 00 c1 c7 ff ff 01 01 00 05=A0</div><div>e0: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div><br></div><div>=A00x295 0x296 8 _______________________________</div><=
div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0=
c =A0d =A0e =A0f</div><div>00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01=
 01=A0</div><div>10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6=A0</di=
v>

<div>20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f=A0</div><div>40: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 08 a3=A0</div><div>50: 00 ff ff ff 00 10 02 =
c8 ff 06 ff ff 08 ff ff 14=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div>80: 04 ff 04 ff=
 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 ff 10 00 04 01 01 =
3c 03 07 00 00 1d ff ff c6=A0</div>

<div>a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 08 a3=A0</div><div>d0: 00 ff ff ff 00 10 02 =
c8 ff 06 ff ff 08 ff ff 14=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div><br></div><div>=
=A00x295 0x296 9 _______________________________</div><div>=A0 =A0 =A00 =A0=
1 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =A0e =A0f</di=
v>

<div>00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>10: 0=
4 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6=A0</div><div>20: 74 d8 d3 d3=
 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 2f=A0</div>

<div>40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3=A0</div><div>50: 0=
1 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff=A0</div><div>60: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div>80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 0=
4 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6=A0</div><div>a0: 74 d8 d3 d3=
 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 2f=A0</div>

<div>c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3=A0</div><div>d0: 0=
1 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff=A0</div><div>e0: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div><br></div><div>=A00x295 0x296 10 _______________________________</div>=
<div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f</div><div>00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c=
 01 01=A0</div><div>10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6=A0<=
/div>

<div>20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f=A0</div><div>40: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 0a a3=A0</div><div>50: 01 00 00 00 00 00 00 =
ff ff ff ff ff ff ff ff ff=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div>80: 04 ff 04 ff=
 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 ff 10 00 04 01 01 =
3c 03 07 00 00 1d ff ff c6=A0</div>

<div>a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 0a a3=A0</div><div>d0: 01 00 00 00 00 00 00 =
ff ff ff ff ff ff ff ff ff=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div><br></div><div>=
=A00x295 0x296 11 _______________________________</div><div>=A0 =A0 =A00 =
=A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =A0e =A0f<=
/div>

<div>00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>10: 0=
4 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6=A0</div><div>20: 74 d8 d3 d3=
 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 2f=A0</div>

<div>40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3=A0</div><div>50: 0=
1 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff=A0</div><div>60: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div>80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 0=
4 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c8=A0</div><div>a0: 74 d8 d3 d3=
 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 2f=A0</div>

<div>c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3=A0</div><div>d0: 0=
1 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff=A0</div><div>e0: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

</div><div><br></div><div><br></div><div><br></div><div>&quot;High Density =
Mode&quot;--------------------------------------------------</div><div><div=
>pwm1 =A0 =A063</div><div>pwm1_enable =A0 =A01</div><div>pwm1_max_output =
=A0 =A0255</div>

<div>pwm1_mode =A0 =A00</div><div>pwm1_start_output =A0 =A01</div><div>pwm1=
_step_output =A0 =A01</div><div>pwm1_stop_output =A0 =A01</div><div>pwm1_st=
op_time =A0 =A024000</div><div>pwm1_target =A0 =A030000</div><div>pwm1_tole=
rance =A0 =A00</div><div>

<br></div><div>pwm2 =A0 =A063</div><div>pwm2_enable =A0 =A02</div><div>pwm2=
_max_output =A0 =A0255</div><div>pwm2_mode =A0 =A01</div><div>pwm2_start_ou=
tput =A0 =A01</div><div>pwm2_step_output =A0 =A01</div><div>pwm2_stop_outpu=
t =A0 =A0128</div><div>
pwm2_stop_time =A0 =A06000</div>
<div>pwm2_target =A0 =A0127000</div><div>pwm2_tolerance =A0 =A02000</div><d=
iv><br></div><div>pwm3 =A0 =A063</div><div>pwm3_enable =A0 =A01</div><div>p=
wm3_max_output =A0 =A0255</div><div>pwm3_mode =A0 =A01</div><div>pwm3_start=
_output =A0 =A01</div><div>

pwm3_step_output =A0 =A01</div><div>pwm3_stop_output =A0 =A01</div><div>pwm=
3_stop_time =A0 =A06000</div><div>pwm3_target =A0 =A030000</div><div>pwm3_t=
olerance =A0 =A04000</div><div><br></div><div>0x295 0x296 0 _______________=
________________</div>

<div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f</div><div>00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c=
 01 01=A0</div><div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c6=A0<=
/div><div>20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3=A0</div>

<div>30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>40: 0=
1 00 00 ff ff 38 3f f5 2d 04 80 c0 10 95 00 a3=A0</div><div>50: ff ff 00 ff=
 ff ff 00 00 c1 cf ff ff 01 01 00 05=A0</div><div>60: ff ff 40 ff ff ff ff =
ff 01 ff 01 ff 01 ff ff ff=A0</div>

<div>70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 0=
4 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 3f 10 1e=
 04 01 01 3c 03 07 00 00 1e ff ff c6=A0</div><div>a0: 72 d9 d3 d3 d2 d3 ba =
05 5b 98 5b bb 4b eb bb e3=A0</div>

<div>b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>c0: 0=
1 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3=A0</div><div>d0: ff ff 00 ff=
 ff ff 00 00 c1 cf ff ff 01 01 00 05=A0</div><div>e0: ff ff 40 ff ff ff ff =
ff 01 ff 01 ff 01 ff ff ff=A0</div>

<div>f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div><br><=
/div><div>=A00x295 0x296 8 _______________________________</div><div>=A0 =
=A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =
=A0e =A0f</div><div>00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0<=
/div>

<div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c6=A0</div><div>20: 7=
2 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5=
 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>40: 01 00 00 ff ff 00 3f =
f5 2d 04 80 c0 10 95 08 a3=A0</div>

<div>50: 00 ff ff ff 00 10 02 c8 3f 05 80 3f 06 ff 3f 16=A0</div><div>60: f=
f ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01=
 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 04 3f 04 3f 11 1e ff =
20 01 80 01 01 3c 3c 01 01=A0</div>

<div>90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c6=A0</div><div>a0: 7=
2 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5=
 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>c0: 01 00 00 ff ff 00 3f =
f5 2d 04 80 c0 10 95 08 a3=A0</div>

<div>d0: 00 ff ff ff 00 10 02 c8 3f 05 80 3f 06 ff 3f 16=A0</div><div>e0: f=
f ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01=
 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div><br></div><div>=A00x295 0=
x296 9 _______________________________</div>

<div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f</div><div>00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c=
 01 01=A0</div><div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8=A0<=
/div><div>20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3=A0</div>

<div>30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>40: 0=
1 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3=A0</div><div>50: 01 1e 3c 4c=
 ff ff ff 3f ff ff ff ff ff 3f 3f 3f=A0</div><div>60: ff ff 40 ff ff ff ff =
ff 01 ff 01 ff 01 ff ff ff=A0</div>

<div>70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 0=
4 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 3f 10 1e=
 04 01 01 3c 03 07 00 00 1e ff ff c8=A0</div><div>a0: 72 d9 d3 d3 d2 d3 ba =
05 5b 98 5b bb 4b eb bb e3=A0</div>

<div>b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>c0: 0=
1 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 09 a3=A0</div><div>d0: 01 1e 3c 4c=
 ff ff ff 3f ff ff ff ff ff 3f 3f 3f=A0</div><div>e0: ff ff 40 ff ff ff ff =
ff 01 ff 01 ff 01 ff ff ff=A0</div>

<div>f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div><br><=
/div><div>=A00x295 0x296 10 _______________________________</div><div>=A0 =
=A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =
=A0e =A0f</div><div>00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0<=
/div>

<div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8=A0</div><div>20: 7=
2 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5=
 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>40: 01 00 00 ff ff 00 3f =
f5 2d 04 80 c0 10 95 0a a3=A0</div>

<div>50: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff ff ff ff=A0</div><div>60: f=
f ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01=
 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 04 3f 04 3f 11 1e ff =
20 01 80 01 01 3c 3c 01 01=A0</div>

<div>90: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8=A0</div><div>a0: 7=
2 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5=
 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>c0: 01 00 00 ff ff 00 3f =
f5 2d 04 80 c0 10 95 0a a3=A0</div>

<div>d0: 01 1e 3c 4c ff ff ff 3f ff ff ff ff ff ff ff ff=A0</div><div>e0: f=
f ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01=
 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div><br></div><div>=A00x295 0=
x296 11 _______________________________</div>

<div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f</div><div>00: 04 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c=
 01 01=A0</div><div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 1e ff ff c8=A0<=
/div><div>20: 72 d9 d3 d3 d2 d3 ba 05 5b 98 5b bb 4b eb bb e3=A0</div>

<div>30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>40: 0=
1 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3=A0</div><div>50: 01 1e 3c 4c=
 ff ff ff 3f ff ff ff ff ff 3f 3f 3f=A0</div><div>60: ff ff 40 ff ff ff ff =
ff 01 ff 01 ff 01 ff ff ff=A0</div>

<div>70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 0=
4 3f 04 3f 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 3f 10 1e=
 04 01 01 3c 03 07 00 00 1e ff ff c8=A0</div><div>a0: 72 d9 d3 d3 d2 d3 ba =
05 5b 98 5b bb 4b eb bb e3=A0</div>

<div>b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 5b=A0</div><div>c0: 0=
1 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0b a3=A0</div><div>d0: 01 1e 3c 4c=
 ff ff ff 3f ff ff ff ff ff 3f 3f 3f=A0</div><div>e0: ff ff 40 ff ff ff ff =
ff 01 ff 01 ff 01 ff ff ff=A0</div>

<div>f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div></div><div=
><br></div><div><br></div><div><br></div><div>&quot;Generic Mode&quot;-----=
---------------------------------------------</div><div><div>pwm1 =A0 =A051=
</div>

<div>pwm1_enable =A0 =A01</div><div>pwm1_max_output =A0 =A0255</div><div>pw=
m1_mode =A0 =A00</div><div>pwm1_start_output =A0 =A01</div><div>pwm1_step_o=
utput =A0 =A01</div><div>pwm1_stop_output =A0 =A01</div><div>pwm1_stop_time=
 =A0 =A024000</div><div>

pwm1_target =A0 =A030000</div><div>pwm1_tolerance =A0 =A00</div><div><br></=
div><div>pwm2 =A0 =A051</div><div>pwm2_enable =A0 =A02</div><div>pwm2_max_o=
utput =A0 =A0255</div><div>pwm2_mode =A0 =A01</div><div>pwm2_start_output =
=A0 =A01</div><div>pwm2_step_output =A0 =A01</div>

<div>pwm2_stop_output =A0 =A0128</div><div>pwm2_stop_time =A0 =A06000</div>=
<div>pwm2_target =A0 =A0127000</div><div>pwm2_tolerance =A0 =A02000</div><d=
iv><br></div><div>pwm3 =A0 =A051</div><div>pwm3_enable =A0 =A01</div><div>p=
wm3_max_output =A0 =A0255</div>

<div>pwm3_mode =A0 =A01</div><div>pwm3_start_output =A0 =A01</div><div>pwm3=
_step_output =A0 =A01</div><div>pwm3_stop_output =A0 =A01</div><div>pwm3_st=
op_time =A0 =A06000</div><div>pwm3_target =A0 =A030000</div><div>pwm3_toler=
ance =A0 =A04000</div><div>

<br></div><div>0x295 0x296 0 _______________________________</div><div>=A0 =
=A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =
=A0e =A0f</div><div>00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0<=
/div><div>10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff dc=A0</div>

<div>20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62=A0</div><div>40: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 00 a3=A0</div><div>50: ff ff 00 ff ff ff 00 =
00 c1 cf ff ff 01 01 00 05=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div>80: 04 33 04 33=
 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 33 10 1e 04 01 01 =
3c 03 07 00 00 1f ff ff dc=A0</div>

<div>a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 00 a3=A0</div><div>d0: ff ff 00 ff ff ff 00 =
00 c1 cf ff ff 01 01 00 05=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div><br></div><div>=
=A00x295 0x296 8 _______________________________</div><div>=A0 =A0 =A00 =A0=
1 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =A0e =A0f</di=
v>

<div>00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>10: 0=
4 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff dc=A0</div><div>20: 6f d8 d3 d3=
 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 62=A0</div>

<div>40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3=A0</div><div>50: 0=
0 ff ff ff 00 10 02 c8 33 06 7f 33 08 ff 33 16=A0</div><div>60: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div>80: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 0=
4 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff dc=A0</div><div>a0: 6f d8 d3 d3=
 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 62=A0</div>

<div>c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3=A0</div><div>d0: 0=
0 ff ff ff 00 10 02 c8 33 06 7f 33 08 ff 33 16=A0</div><div>e0: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div><br></div><div>=A00x295 0x296 9 _______________________________</div><=
div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0=
c =A0d =A0e =A0f</div><div>00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01=
 01=A0</div><div>10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0=A0</di=
v>

<div>20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62=A0</div><div>40: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 09 a3=A0</div><div>50: 01 1e 3c 4c ff ff ff =
33 80 ff ff ff ff 33 33 33=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div>80: 04 33 04 33=
 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 33 10 1e 04 01 01 =
3c 03 07 00 00 1f ff ff c0=A0</div>

<div>a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 09 a3=A0</div><div>d0: 01 1e 3c 4c ff ff ff =
33 80 ff ff ff ff 33 33 33=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div><br></div><div>=
=A00x295 0x296 10 _______________________________</div><div>=A0 =A0 =A00 =
=A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =A0e =A0f<=
/div>

<div>00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>10: 0=
4 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0=A0</div><div>20: 6f d8 d3 d3=
 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 62=A0</div>

<div>40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3=A0</div><div>50: 0=
1 1e 3c 4c ff ff ff 33 80 ff ff ff ff ff ff ff=A0</div><div>60: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div>80: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 0=
4 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0=A0</div><div>a0: 6f d8 d3 d3=
 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5 bb ff dc =
ce a8 3c 3a b6 3f 82 c1 62=A0</div>

<div>c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 0a a3=A0</div><div>d0: 0=
1 1e 3c 4c ff ff ff 33 80 ff ff ff ff ff ff ff=A0</div><div>e0: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 80 01 ca 00=A0</div>

<div><br></div><div>=A00x295 0x296 11 _______________________________</div>=
<div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f</div><div>00: 04 33 04 33 11 1e ff 20 01 80 01 01 3c 3c=
 01 01=A0</div><div>10: 04 33 10 1e 04 01 01 3c 03 07 00 00 1f ff ff c0=A0<=
/div>

<div>20: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62=A0</div><div>40: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 0b a3=A0</div><div>50: 01 1e 3c 4c ff ff ff =
33 80 ff ff ff ff 33 33 33=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div><div>80: 04 33 04 33=
 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 33 10 1e 04 01 01 =
3c 03 07 00 00 1f ff ff c0=A0</div>

<div>a0: 6f d8 d3 d3 d1 d3 ba 06 61 9a 60 bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 62=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f f5 2d 04 80 c0 10 95 0b a3=A0</div><div>d0: 01 1e 3c 4c ff ff ff =
33 80 ff ff ff ff 33 33 33=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00=A0</div></div><div><br></div=
><div><br></div><div><br></div><div>&quot;Whisper Mode&quot;---------------=
-----------------------------------</div>

<div><div>pwm1 =A0 =A00</div><div>pwm1_enable =A0 =A01</div><div>pwm1_max_o=
utput =A0 =A0255</div><div>pwm1_mode =A0 =A00</div><div>pwm1_start_output =
=A0 =A01</div><div>pwm1_step_output =A0 =A01</div><div>pwm1_stop_output =A0=
 =A01</div><div>pwm1_stop_time =A0 =A024000</div>

<div>pwm1_target =A0 =A030000</div><div>pwm1_tolerance =A0 =A00</div><div><=
br></div><div>pwm2 =A0 =A00</div><div>pwm2_enable =A0 =A02</div><div>pwm2_m=
ax_output =A0 =A0255</div><div>pwm2_mode =A0 =A01</div><div>pwm2_start_outp=
ut =A0 =A01</div><div>pwm2_step_output =A0 =A01</div>

<div>pwm2_stop_output =A0 =A0128</div><div>pwm2_stop_time =A0 =A06000</div>=
<div>pwm2_target =A0 =A0127000</div><div>pwm2_tolerance =A0 =A02000</div><d=
iv><br></div><div>pwm3 =A0 =A063</div><div>pwm3_enable =A0 =A01</div><div>p=
wm3_max_output =A0 =A0255</div>

<div>pwm3_mode =A0 =A01</div><div>pwm3_start_output =A0 =A01</div><div>pwm3=
_step_output =A0 =A01</div><div>pwm3_stop_output =A0 =A01</div><div>pwm3_st=
op_time =A0 =A06000</div><div>pwm3_target =A0 =A030000</div><div>pwm3_toler=
ance =A0 =A04000</div><div>

<br></div><div>0x295 0x296 0 _______________________________</div><div>=A0 =
=A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =
=A0e =A0f</div><div>00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0<=
/div><div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8=A0</div>

<div>20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff=A0</div><div>40: 01 40 00 ff=
 ff 00 3f c5 2d 04 80 00 90 95 00 a3=A0</div><div>50: ff ff 00 ff ff ff 00 =
00 c1 c0 ff ff 01 a1 00 05=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 04 00 04 00=
 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 3f 10 1e 04 01 01 =
3c 03 07 00 00 21 ff ff d8=A0</div>

<div>a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f c5 2d 04 80 00 90 95 00 a3=A0</div><div>d0: ff ff 00 ff ff ff 00 =
00 c1 c0 ff ff 01 a1 00 05=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div><br></div><div>=
=A00x295 0x296 8 _______________________________</div><div>=A0 =A0 =A00 =A0=
1 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =A0e =A0f</di=
v>

<div>00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>10: 0=
4 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8=A0</div><div>20: 6f d8 d3 d3=
 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5 bb ff dc =
ce a8 3c 3a 5b 3f 41 60 ff=A0</div>

<div>40: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 08 a3=A0</div><div>50: 0=
0 ff ff ff 00 10 02 c8 00 09 7f 00 0a ff 3f 16=A0</div><div>60: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 00 01 ca 00=A0</div>

<div>80: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 0=
4 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8=A0</div><div>a0: 6f d8 d3 d3=
 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5 bb ff dc =
ce a8 3c 3a 5b 3f 41 60 ff=A0</div>

<div>c0: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 08 a3=A0</div><div>d0: 0=
0 ff ff ff 00 10 02 c8 00 09 7f 00 0a ff 3f 16=A0</div><div>e0: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 00 01 ca 00=A0</div>

<div><br></div><div>=A00x295 0x296 9 _______________________________</div><=
div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0=
c =A0d =A0e =A0f</div><div>00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01=
 01=A0</div><div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff d8=A0</di=
v>

<div>20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff=A0</div><div>40: 01 00 00 ff=
 ff 00 3f c5 2d 04 80 00 90 95 09 a3=A0</div><div>50: 01 1e 3c 4c ff ff ff =
00 19 ff ff ff ff 00 00 3f=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 04 00 04 00=
 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 3f 10 1e 04 01 01 =
3c 03 07 00 00 21 ff ff da=A0</div>

<div>a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f c5 2d 04 80 00 90 95 09 a3=A0</div><div>d0: 01 1e 3c 4c ff ff ff =
00 19 ff ff ff ff 00 00 3f=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div><br></div><div>=
=A00x295 0x296 10 _______________________________</div><div>=A0 =A0 =A00 =
=A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =A0c =A0d =A0e =A0f<=
/div>

<div>00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>10: 0=
4 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da=A0</div><div>20: 6f d8 d3 d3=
 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>30: ba e3 ba e5 bb ff dc =
ce a8 3c 3a 5b 3f 41 60 ff=A0</div>

<div>40: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 0a a3=A0</div><div>50: 0=
1 1e 3c 4c ff ff ff 00 19 ff ff ff ff ff ff ff=A0</div><div>60: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 00 01 ca 00=A0</div>

<div>80: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 0=
4 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da=A0</div><div>a0: 6f d8 d3 d3=
 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>b0: ba e3 ba e5 bb ff dc =
ce a8 3c 3a 5b 3f 41 60 ff=A0</div>

<div>c0: 01 00 00 ff ff 00 3f c5 2d 04 80 00 90 95 0a a3=A0</div><div>d0: 0=
1 1e 3c 4c ff ff ff 00 19 ff ff ff ff ff ff ff=A0</div><div>e0: ff ff 40 ff=
 ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 01 01 04 01 00 4b 4b =
4b ff ff ff 1f 00 01 ca 00=A0</div>

<div><br></div><div>=A00x295 0x296 11 _______________________________</div>=
<div>=A0 =A0 =A00 =A01 =A02 =A03 =A04 =A05 =A06 =A07 =A08 =A09 =A0a =A0b =
=A0c =A0d =A0e =A0f</div><div>00: 04 00 04 00 11 1e ff 20 01 80 01 01 3c 3c=
 01 01=A0</div><div>10: 04 3f 10 1e 04 01 01 3c 03 07 00 00 21 ff ff da=A0<=
/div>

<div>20: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>30: b=
a e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff=A0</div><div>40: 01 00 00 ff=
 ff 00 3f c5 2d 04 80 00 90 95 0b a3=A0</div><div>50: 01 1e 3c 4c ff ff ff =
00 19 ff ff ff ff 00 00 3f=A0</div>

<div>60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>70: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div><div>80: 04 00 04 00=
 11 1e ff 20 01 80 01 01 3c 3c 01 01=A0</div><div>90: 04 3f 10 1e 04 01 01 =
3c 03 07 00 00 21 ff ff da=A0</div>

<div>a0: 6f d8 d3 d3 d1 d3 ba 09 ff 9d ff bb 4b eb bb e3=A0</div><div>b0: b=
a e3 ba e5 bb ff dc ce a8 3c 3a 5b 3f 41 60 ff=A0</div><div>c0: 01 00 00 ff=
 ff 00 3f c5 2d 04 80 00 90 95 0b a3=A0</div><div>d0: 01 1e 3c 4c ff ff ff =
00 19 ff ff ff ff 00 00 3f=A0</div>

<div>e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff=A0</div><div>f0: 0=
1 01 04 01 00 4b 4b 4b ff ff ff 1f 00 01 ca 00=A0</div></div><div><br></div=
><div><br></div><div><br></div></div>

--e89a8fb206d43448a104ccd84b5a--


--===============0006515408093384284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0006515408093384284==--

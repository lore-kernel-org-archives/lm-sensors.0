From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Oct 2012 13:48:54 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <20121025134854.GA7032@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 24, 2012 at 06:40:33PM -0700, camden lindsay wrote:
> >
> > Hi,
> >
> > Please don't top-post.
> >
> > If you set anything but full speed mode, do you see different pwm values ?
> >
> > Also, please provide the output of
> >
> >         sudo isadump -y 0x295 0x296 0
> >         sudo isadump -y 0x295 0x296 8
> >         sudo isadump -y 0x295 0x296 9
> >         sudo isadump -y 0x295 0x296 10
> >         sudo isadump -y 0x295 0x296 11
> >
> > Thanks,
> > Guenter
> >
> >
> Sorry about the top-post, its a habit from working for years in gmail and
> never really taking part in mailing lists;  I really don't know the correct
> mannerisms.
> 
> Yes, pwm{1..3} change depending on the fan mode set in bios.
> Out of curiosity, is there a datasheet for the chip floating around?  It
> seems the manufacturer makes it on-request-only.  I couldn't find it online
> anywhere particularly easily... lots of bad results in a search.
> 
> 
> Hopefully this isn't too much to parse, but i've provided the
> /sys/bus/hwmon and the isadump  output for each of the fan settings  in bios
> 
> Thanks!
> Camden
> 
> "Full speed mode"--------------------------------------------------
> pwm1    255
> pwm1_enable    1
> pwm1_max_output    255
> pwm1_mode    0
> pwm1_start_output    1
> pwm1_step_output    1
> pwm1_stop_output    1
> pwm1_stop_time    24000
> pwm1_target    0
> pwm1_tolerance    0
> 
> pwm2    255
> pwm2_enable    2
> pwm2_max_output    255
> pwm2_mode    1
> pwm2_start_output    1
> pwm2_step_output    1
> pwm2_stop_output    128
> pwm2_stop_time    6000
> pwm2_target    0
> pwm2_tolerance    2000
> 
> pwm3    255
> pwm3_enable    1
> pwm3_max_output    255
> pwm3_mode    1
> pwm3_start_output    1
> pwm3_step_output    1
> pwm3_stop_output    1
> pwm3_stop_time    6000
> pwm3_target    0
> pwm3_tolerance    4000
> 
> 0x295 0x296 0 _______________________________
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
> 10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c4
> 20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
> 30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
> 40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3
> 50: ff ff 00 ff ff ff 00 00 c1 c7 ff ff 01 01 00 05
> 60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
> 70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
> 80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
> 90: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
> a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
> b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
> c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 00 a3
> d0: ff ff 00 ff ff ff 00 00 c1 c7 ff ff 01 01 00 05
> e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
> f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
> 
>  0x295 0x296 8 _______________________________
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
> 10: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
> 20: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
> 30: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
> 40: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
> 50: 00 ff ff ff 00 10 02 c8 ff 06 ff ff 08 ff ff 14
> 60: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
> 70: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
> 80: 04 ff 04 ff 11 00 00 20 01 80 01 01 3c 3c 01 01
> 90: 04 ff 10 00 04 01 01 3c 03 07 00 00 1d ff ff c6
> a0: 74 d8 d3 d3 d2 d3 ba 06 2f 5b 30 bb 4b eb bb e3
> b0: ba e3 ba e5 bb ff dc ce a8 3c 3a b6 3f 82 c1 2f
> c0: 01 00 00 ff ff 00 3f f5 2d 04 80 c0 10 95 08 a3
> d0: 00 ff ff ff 00 10 02 c8 ff 06 ff ff 08 ff ff 14
> e0: ff ff 40 ff ff ff ff ff 01 ff 01 ff 01 ff ff ff
> f0: 01 01 04 01 00 4b 4b 4b ff ff ff 1f 80 01 ca 00
> 
Guess that didn't work - it always prints the same data. I'll look into it
anyway - maybe there is some bit setting on this page that helps.

Another question. When you select the low noise modes, does the fan speed (pwm
value) change with CPU load ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

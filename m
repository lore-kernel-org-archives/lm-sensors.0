From: Shao bin Li <shaobinlee@gmail.com>
Date: Wed, 19 Jan 2011 05:11:08 +0000
Subject: [lm-sensors] rtc can not work (mpc8270 + ds1138 + kernel 2.6.15)
Message-Id: <AANLkTin2TJoQ-xCJ9xs--FQ6tf_8hjJfukxB6fDNKGf=@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8052472919036359578=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8052472919036359578==
Content-Type: multipart/alternative; boundary=20cf3054a62d727650049a2c0b14

--20cf3054a62d727650049a2c0b14
Content-Type: text/plain; charset=ISO-8859-1

hello there,

I encounter some problem that rtc can not work.

The platform I used is MPC8270, and the kernel is 2.6.15.
There are two i2c devices: max 1619 and a rtc ds1338.

I add a i2c-mp8260 patch include:
driver/i2c/busses/i2c-mpc8260.c
include/linux/i2c-algo-8260.h
include/linux/i2c-id.h
to enable i2c-mpc8260 adapater to work.
and add
 drivers/i2c/chip/ds1338.c
to support rtc ds1338 chip.

In the configuration of kernel, select hwmon and max1619,
the max1619 work well after boot uImage.

For ds1338, select char device->gen_rtc and gen_rtc_x,
and ds1338 chip driver.

I use i2cdetect to find that, the max 1619 is at address 0x18,
but the address 0x68 (should be slave address of ds1338) is
not occupied by ds1338.

I guess rtc can not work due to there is no binding process for
ds1338 driver and i2c adapter, and the i2c controller don't know
the exist of rtc ds1338. But I don't know how to bind.

In the kernel such as 2.6.20 and after, there  are i2c_board_info structure
and i2c_board_info_register function to tell the board the exist of rtc. But
in
the kernel of 2.6.14, 2.6.15, 2.6.17, etc, there is no. There must be some
way
to do binding job.  Anybody know that?  Please!

--20cf3054a62d727650049a2c0b14
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>hello there,</div>
<div>=A0</div>
<div>I encounter some problem that rtc can not work.</div>
<div>=A0</div>
<div>The platform I used is MPC8270, and the kernel is 2.6.15.</div>
<div>There are two i2c devices: max 1619 and a rtc ds1338.</div>
<div>=A0</div>
<div>I add a i2c-mp8260 patch include:</div>
<div>driver/i2c/busses/i2c-mpc8260.c</div>
<div>include/linux/i2c-algo-8260.h</div>
<div>include/linux/i2c-id.h</div>
<div>to enable i2c-mpc8260 adapater to work.</div>
<div>and add </div>
<div>
<div>drivers/i2c/chip/ds1338.c</div>
<div>to support rtc ds1338 chip.</div>
<div>=A0</div>
<div>In the configuration of kernel, select hwmon and max1619,</div>
<div>the max1619 work well after boot uImage.</div>
<div>=A0</div>
<div>For ds1338, select char device-&gt;gen_rtc and gen_rtc_x,</div>
<div>and ds1338 chip driver.</div></div>
<div>=A0</div>
<div>I use i2cdetect to find that, the max 1619 is at address 0x18,</div>
<div>but the=A0address=A00x68 (should be slave address of ds1338) is=A0</di=
v>
<div>not occupied by ds1338.</div>
<div>=A0</div>
<div>I guess rtc can not work due to there is no binding process for</div>
<div>ds1338=A0driver and i2c adapter, and the i2c controller don&#39;t know=
 </div>
<div>the exist of rtc ds1338. But I don&#39;t know how to bind. </div>
<div>=A0</div>
<div>In the kernel=A0such as 2.6.20 and after, there =A0are i2c_board_info =
structure</div>
<div>and i2c_board_info_register function to tell the board the exist of rt=
c. But in</div>
<div>the kernel of 2.6.14, 2.6.15, 2.6.17, etc, there is no. There must be =
some way</div>
<div>to do binding job.=A0 Anybody know that?=A0 Please!</div>
<div>=A0</div>
<div>=A0</div>

--20cf3054a62d727650049a2c0b14--


--===============8052472919036359578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8052472919036359578==--

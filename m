From: Andrew Lutomirski <luto@mit.edu>
Date: Fri, 04 Mar 2011 18:53:41 +0000
Subject: Re: [lm-sensors] [PATCH v5 00/11] hwmon: (w83627ehf) Add support
Message-Id: <AANLkTi=yYOMA-eHnjzQDsLoH6RFtrG6b71HcjUMwjxNV@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com> <AANLkTinNrOG69Kzy=ZfRjurOedsz2Oazt-FT-m3Ro6Gg@mail.gmail.com>
In-Reply-To: <AANLkTinNrOG69Kzy=ZfRjurOedsz2Oazt-FT-m3Ro6Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Ian Dobson <i.dobson@planet-ian.com>, Randy Dunlap <rdunlap@xenotime.net>, binximeng@gmail.com, lmsensors@tapanitarvainen.fi, andrea.rizzolo@gmail.com, jeff.sadowski@gmail.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 4, 2011 at 1:50 PM, Andrew Lutomirski <luto@mit.edu> wrote:
> On Fri, Mar 4, 2011 at 12:57 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
>> The following patch series adds support for NCT6775F and NCT6776F to the
>> w83627ehf driver. It also includes some cleanup and adds support for
>> the fourth temperature sensor on W83677HG-B.
>>
>> No code changes since v4. Resubmitting and widening audience in the hope=
 that
>> someone may find the time to review the changes prior to the next commit=
 window.
>
> I'm not sure my review is worth much, but the driver seems to work. =A0I'=
ve tested
> fan speed measurement, changing pwm2_enable to 1, changing the fan speed,
> and changing back to 5. =A0Everything looks good.
>
> The only weird thing I noticed is that, the first time I ran sensors, I g=
ot:
> fan2: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 R=
PM, div =3D 64)
> and thereafter I get
> fan2: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0136 RPM =A0(min =3D =A0 =A00 RPM=
, div =3D 64) =A0ALARM
>
> I suspect (although I haven't checked) that sensors is just reading
> div after it's already changed to 64.

I'll add one more weird thing on my NCT6775F.

[root@midnight w83627ehf.656]# echo 3200 >fan2_min
[root@midnight w83627ehf.656]# cat fan2_div
8
[root@midnight w83627ehf.656]# cat fan2_input
133
[root@midnight w83627ehf.656]# cat fan2_div
16
[root@midnight w83627ehf.656]# cat fan2_input
133
[root@midnight w83627ehf.656]# cat fan2_div
32
[root@midnight w83627ehf.656]# cat fan2_input
133
[root@midnight w83627ehf.656]# cat fan2_div
64
[root@midnight w83627ehf.656]# cat fan2_input
132
[root@midnight w83627ehf.656]# cat fan2_div
64

I waited a second or two between commands.

Does this mean that 16-bit mode works but the driver doesn't realize it wor=
ks?

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

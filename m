From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 18 Apr 2008 20:50:36 +0000
Subject: Re: [lm-sensors] Linux 2.6.25
Message-Id: <4809099C.9010308@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com> <e2e108260804181218u70f096dfr864cdd13d1d4d2f3@mail.gmail.com> <48090395.6080202@gmail.com>
In-Reply-To: <48090395.6080202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Bart Van Assche <bart.vanassche@gmail.com>, Matthew <jackdachef@gmail.com>, torvalds@linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gene Heskett <gene.heskett@gmail.com>, LM Sensors <lm-sensors@lm-sensors.org>

Hi all,

I will keep the rest of the mail intact for the lm-sensors list. The temper=
ature=20
is stored in hardware relative to maximum temperature. Mobile processors ha=
ve=20
some undocumented bits that calibrate the temperature to 85 or 100C. Intel =

claims that this does not work for desktops, so I changed the driver [1] an=
d=20
scale for desktop CPUs is from 0 to 100.

In your case, the MAX temperature is changed from 85 to 100 for desktops Bu=
t the=20
relative change is same, in your case -40C below the max [2]. You should no=
w see=20
instead of 40 around 60. Because it was 85 - 40 and now it is 100 - 40. Sec=
ond=20
problem is that the scale is not linear so it works more fine close to the =
MAX.

I think it is what happened. If you change the driver, so it will take 85C =

instead of 100C everything should go back to "normal". I'm sorry I did not =

invent relative only temp measurements, therefore I would recommend to watc=
h how=20
much is left to max temperature.

Hope it explains it,

Thanks,
Rudolf

[1]=20
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=118a88718886a6cb7fb2cf7fb77ef2eea30c73a1
[2]
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob=
;f=3DDocumentation/hwmon/coretemp;hb=3DHEAD


Jiri Slaby napsal(a):
> On 04/18/2008 09:18 PM, Bart Van Assche wrote:
>> On Fri, Apr 18, 2008 at 5:37 PM, Matthew <jackdachef@gmail.com> wrote:
>>>  I've another "regression" to report for 2.6.25:
>>>
>>>  it's concerning much higher temperatures being read out by the
>>>  "coretemp" kernel-module in comparison to 2.6.24* series
>>>
>>>  e.g. where temperatures were around 40-47=B0C they are now constantly
>>>  jumping around 55-70=B0C (even in idle !)
>>
>> The coretemp kernel module reports 25=B0C on my PC when idle, and 34=B0C
>> after having performed some computations (lmbench2). This looks
>> normal. This test has been performed with a vanilla 2.6.25 kernel and
>> a Core 2 Duo E6750 CPU (Asus motherboard). The 2.6.22 and 2.6.24
>> kernels report an incorrect temperature on the same system however
>> (10=B0C). So there is either an issue with the patches that have been
>> applied to your kernel or the behavior of the coretemp module for the
>> 6600 and E6750 CPU's is different. Can you repeat the test with a
>> vanilla 2.6.25 kernel ?
>>
>> (Added Rudolf Marek in CC, the coretemp author.)
>=20
> I see a change on my rrd graphs on Mar 5th 11:30 AM (from 25 to 40=20
> average centigrades). This is when I booted 2.6.25-rc3-mm1 instead of=20
> 2.6.25-rc2-mm1, according to logs. [I have no idea whether the values=20
> were correct before or are correct now.]
>=20
> I might bisect it, if needed.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Manuel Krause <manuelkrause@netscape.net>
Date: Fri, 07 Mar 2014 22:04:29 +0000
Subject: Re: [lm-sensors] 3.13.?: Strange / dangerous fan policy...
Message-Id: <531A426D.6080100@netscape.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <531A1EEE.9090101@netscape.net> <20140307205506.GA6870@roeck-us.net>
In-Reply-To: <20140307205506.GA6870@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org

On 2014-03-07 21:55, Guenter Roeck wrote:
> On Fri, Mar 07, 2014 at 08:33:02PM +0100, Manuel Krause wrote:
>> Please have a short look at the following BUG report + the comments
>> -- this message here is a kind of FWD-ing it:
>> https://bugs.archlinux.org/task/39005
>>
>> I came late to test kernel 3.13 with the .5 one, as it was the time
>> that the related -CK/BFS patch became available.
>>
>> I'm not using Archlinux, but openSUSE, and my problems are quite the
>> same. Especially these with smelling melting plastics.
>>
>> My own reports went to Con Kolivas' Blog first:
>> "I get weird temperatures and abrupt 100% fan actions with vanilla
>> 3.13.5 with this CK and most recent BFQ at my HP Notebook.
>> In gkrellm the highest T had been @74=B0C, so far (3.12.13), and is
>> now growing to 94=B0C. Then, the fan goes to 100% for 10~30secs
>> cooling it to approx. 82=B0C.
>> That is not good, if I compare 74 to 94 =B0C.
>> Have I missed a .CONFIG option for 3.13, especially?"
>>
>> I'd get the same without (Con's && BFQ's) patches.
>>
>> Machine:           HP Notebook with Core2Duo CPU (Penryn)
>> Distro:            openSUSE 13.1, 64bit, continuously updated
>> Desktop:           KDE 4.12.3
>> MESA & drm & Xorg: most recent ones from:
>> http://download.opensuse.org/repositories/home:/pontostroy:/X11/openSUSE=
_13.1/x86_64/
>>
>> Current kernel:    3.13.6 vanilla from openSUSE repos, with
>>                     -ck1 and BFQ patches
>> Same behaviour:    without these patches
>>
>> Last good kernel:  3.12.13 vanilla + CK2 + BFQ
>>
>
> Can you add more information about your fan control policy ?
> Do you rely on the hardware for automatic fan speed control,
> or do you run the fancontrol script ?
>
> What is the output from the 'sensors' command ?
>
> Thanks,
> Guenter
>

Hi, and thanks for the quick response!
No special fancy "fan control policy". 'fancontrol' isn't up or=20
running.
Vanilla kernels 3.11.* and 3.12.* had been working on here=20
without any extra work.
--
# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:        +71.0=B0C  (crit =3D +256.0=B0C)
temp2:        +69.0=B0C  (crit =3D +110.0=B0C)
temp3:        +52.0=B0C  (crit =3D +105.0=B0C)
temp4:        +25.0=B0C  (crit =3D +110.0=B0C)
temp5:        +58.0=B0C  (crit =3D +110.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +62.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
Core 1:       +60.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
--
My notebook (HP/Compaq 6730b) does not have a seperate fan sensor.
This is with 3.12.13 with my normal workload.

Please, trust my above mentionned values of 94 =B0C vs. 74=B0C as I=20
don't like to boot 3.13.6 anymore, to avoid harm to the=20
notebook's casing.

But I'd do to test any improvement-patch.

Manuel Krause



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

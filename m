From: dag dg <dagofthedofg@gmail.com>
Date: Tue, 19 Mar 2013 02:14:40 +0000
Subject: Re: [lm-sensors] Getting temps for all CPU cores to show up on an AMD chip
Message-Id: <CAO2Qn5n_Sd19OcoZ6wUEZTRUGJpdjGvMLDDh=J7s5bD39=pxzw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4318935730986326881=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO2Qn5nT3FPbyrzJCF3NfyQ2y4sgR62w5JhMQeVNsHEcWY5HDA@mail.gmail.com>
In-Reply-To: <CAO2Qn5nT3FPbyrzJCF3NfyQ2y4sgR62w5JhMQeVNsHEcWY5HDA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============4318935730986326881==
Content-Type: multipart/alternative; boundary=20cf307f37f42d966e04d83dacd5

--20cf307f37f42d966e04d83dacd5
Content-Type: text/plain; charset=ISO-8859-1

Make that 4 cores. I was checking my X4 and my X6 and got them confused.
Same issue on both.


On Mon, Mar 18, 2013 at 9:10 PM, dag dg <dagofthedofg@gmail.com> wrote:

> I wish that was the case so I could close the book but CPUID's HWmonitor:
>
> http://www.cpuid.com/softwares/hwmonitor.html
>
> and OCCT PT
>
> http://www.ocbase.com/
>
> both report all 6 temps which show the temps fluxuating(within a degree of
> each other but still enough to tell they're different measurements)
>
> It's not the end of the world if I can't get all 6 temps but it'd be nice
> to see something in the works. Thanks for the assistance thus far.
>
>
> On Thu, Mar 14, 2013 at 2:56 PM, Clemens Ladisch <clemens@ladisch.de>wrote:
>
>> Jean Delvare wrote:
>> > On Thu, 14 Mar 2013 09:02:40 -0700, Guenter Roeck wrote:
>> >> On Thu, Mar 14, 2013 at 10:26:39AM -0500, dag dg wrote:
>> >>> I have an AMD Phenom II x4 that will show the individual core temps
>> in a
>> >>> few utilities in windows but for the life of me I can't get
>> lm_sensors to
>> >>> display them. I'm using the k10temp and w83627dhg-isa-0290 modules.
>> This is
>> >>> for Fedora 17 lm_sensors version 3.3.2 kernel 3.7.9-104.fc17.x86_64.
>> Here's
>> >>> what I'm seeing at the moment:
>> >>
>> >> The driver only supports reporting a single temperature, so that is not
>> >> surprising. Someone with access to a datasheet and the time to do it
>> >> would have to enhance the driver.
>> >
>> > Clemens, any info?
>>
>> There are no individual core temperatures.
>>
>> I don't know where those utilities get the values, but I'd guess that they
>> simply repeat the same value.
>>
>>
>> Regards,
>> Clemens
>>
>
>

--20cf307f37f42d966e04d83dacd5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Make that 4 cores. I was checking my X4 and my X6 and got =
them confused. Same issue on both.<br><div class=3D"gmail_extra"><br><br><d=
iv class=3D"gmail_quote">On Mon, Mar 18, 2013 at 9:10 PM, dag dg <span dir=
=3D"ltr">&lt;<a href=3D"mailto:dagofthedofg@gmail.com" target=3D"_blank">da=
gofthedofg@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">I wish that was the case so=
 I could close the book but CPUID&#39;s HWmonitor:<div><br></div><div><a hr=
ef=3D"http://www.cpuid.com/softwares/hwmonitor.html" target=3D"_blank">http=
://www.cpuid.com/softwares/hwmonitor.html</a><br>

</div>
<div><br></div><div>and OCCT PT</div><div><br></div><div><a href=3D"http://=
www.ocbase.com/" target=3D"_blank">http://www.ocbase.com/</a><br></div><div=
><br></div><div>both report all 6 temps which show the temps fluxuating(wit=
hin a degree of each other but still enough to tell they&#39;re different m=
easurements)</div>


<div><br></div><div>It&#39;s not the end of the world if I can&#39;t get al=
l 6 temps but it&#39;d be nice to see something in the works. Thanks for th=
e assistance thus far.</div></div><div class=3D"HOEnZb"><div class=3D"h5">

<div class=3D"gmail_extra">
<br><br><div class=3D"gmail_quote">On Thu, Mar 14, 2013 at 2:56 PM, Clemens=
 Ladisch <span dir=3D"ltr">&lt;<a href=3D"mailto:clemens@ladisch.de" target=
=3D"_blank">clemens@ladisch.de</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">


<div><div>Jean Delvare wrote:<br>
&gt; On Thu, 14 Mar 2013 09:02:40 -0700, Guenter Roeck wrote:<br>
&gt;&gt; On Thu, Mar 14, 2013 at 10:26:39AM -0500, dag dg wrote:<br>
&gt;&gt;&gt; I have an AMD Phenom II x4 that will show the individual core =
temps in a<br>
&gt;&gt;&gt; few utilities in windows but for the life of me I can&#39;t ge=
t lm_sensors to<br>
&gt;&gt;&gt; display them. I&#39;m using the k10temp and w83627dhg-isa-0290=
 modules. This is<br>
&gt;&gt;&gt; for Fedora 17 lm_sensors version 3.3.2 kernel 3.7.9-104.fc17.x=
86_64. Here&#39;s<br>
&gt;&gt;&gt; what I&#39;m seeing at the moment:<br>
&gt;&gt;<br>
&gt;&gt; The driver only supports reporting a single temperature, so that i=
s not<br>
&gt;&gt; surprising. Someone with access to a datasheet and the time to do =
it<br>
&gt;&gt; would have to enhance the driver.<br>
&gt;<br>
&gt; Clemens, any info?<br>
<br>
</div></div>There are no individual core temperatures.<br>
<br>
I don&#39;t know where those utilities get the values, but I&#39;d guess th=
at they<br>
simply repeat the same value.<br>
<br>
<br>
Regards,<br>
Clemens<br>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div></div>

--20cf307f37f42d966e04d83dacd5--


--===============4318935730986326881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4318935730986326881==--

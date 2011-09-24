From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Sat, 24 Sep 2011 05:17:00 +0000
Subject: Re: [lm-sensors] AMD Phenom II Family 16h
Message-Id: <CAAek22Fbz6AfhjQM9ymcBNLZYr0_CxUxEiyvtSBoyXk-UQ0qEw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3048653780075999579=="
List-Id: <lm-sensors.vger.kernel.org>
References: <201109232108.25627.pablow.1422@gmail.com>
In-Reply-To: <201109232108.25627.pablow.1422@gmail.com>
To: lm-sensors@vger.kernel.org

--===============3048653780075999579==
Content-Type: multipart/alternative; boundary=90e6ba21226b1f450904ada909ad

--90e6ba21226b1f450904ada909ad
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2011 at 8:50 PM, Guenter Roeck
<guenter.roeck@ericsson.com>wrote:

>
> > it gives me a temp not matching the real (about -10=BAC diff
> > between them)
>

How are you measuring the "real" temperature?  Do you have a thermocouple
inserted between the CPU and heatsink?

Some time ago, AMD changed the temperature scale to a synthetic "Tcontrol"
scale where the reading 70degC is the maximum operating temperature for the
chip.  This simplifies things because  you don't have to know the
particulars of each chip, you can just manage the "temperature" to keep it
below 70 "degC".

Phil P.

--90e6ba21226b1f450904ada909ad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Sep 23, 2011 at 8:50 PM, Guenter Roeck <=
span dir=3D"ltr">&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.=
roeck@ericsson.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204,=
 204); padding-left: 1ex;">
<br>
&gt; it gives me a temp not matching the real (about -10=BAC diff<br>
&gt; between them)<br></blockquote><div><br>How are you measuring the &quot=
;real&quot; temperature?=A0 Do you have a thermocouple inserted between the=
 CPU and heatsink?<br><br>Some time ago, AMD changed the temperature scale =
to a synthetic &quot;Tcontrol&quot; scale where the reading 70degC is the m=
aximum operating temperature for the chip.=A0 This simplifies things becaus=
e=A0 you don&#39;t have to know the particulars of each chip, you can just =
manage the &quot;temperature&quot; to keep it below 70 &quot;degC&quot;.<br=
>
<br>Phil P. <br></div></div>

--90e6ba21226b1f450904ada909ad--


--===============3048653780075999579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3048653780075999579==--

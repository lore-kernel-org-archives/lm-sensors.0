From: Dmitry Gromov <gromovd@gmail.com>
Date: Tue, 18 May 2010 04:47:59 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Update coretemp to current
Message-Id: <AANLkTinQlH7LhCAz00WaHqbbslcSqipzVx4tDoQKSqIL@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5980680991318378332=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100517094136.094800562@osadl.org>
In-Reply-To: <20100517094136.094800562@osadl.org>
To: lm-sensors@vger.kernel.org

--===============5980680991318378332==
Content-Type: multipart/alternative; boundary=00c09ffb4eb3e26a320486d70ca9

--00c09ffb4eb3e26a320486d70ca9
Content-Type: text/plain; charset=ISO-8859-1

Hi!

On Mon, May 17, 2010 at 05:41, Carsten Emde <C.Emde@osadl.org> wrote:

> Hi!
>
> Here comes the current version of the coretemp patches. Huaxu did the
> initial
> work; Jean suggested to submit them directly to Andrew.
>
> I made some style changes as advised by checkpatch.
>
> The patches have been tested successfully on Core 2 Duo and Quad, and on
> Nehalem and Nehalem/Westmere where temperature readings were plausible and
> changed with load as expected. When tested on an Atom processor (N270), the
> temperature values were identical to previous versions of the coretemp
> module and also changed with load. However, the readings should be higher
> by 10 to 15C as compared to the outside temperature of the processor.
> Huaxu,
> could you check? I would guess TjMax to be 105 instead of 90C in these
> processors.
>
>
I apologize, if I ask a stupid question, but are you saying that TjMax in
coretemp.c should be set to higher value than Tcase-max value specified in
Intel documents?

Thanks!

-- 
DG
NJ

--00c09ffb4eb3e26a320486d70ca9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font color=3D"#3333ff"><font size=3D"2"><font face=3D"georgia,serif">Hi!<b=
r></font></font></font><br><div class=3D"gmail_quote">On Mon, May 17, 2010 =
at 05:41, Carsten Emde <span dir=3D"ltr">&lt;<a href=3D"mailto:C.Emde@osadl=
.org">C.Emde@osadl.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi!<br>
<br>
Here comes the current version of the coretemp patches. Huaxu did the initi=
al<br>
work; Jean suggested to submit them directly to Andrew.<br>
<br>
I made some style changes as advised by checkpatch.<br>
<br>
The patches have been tested successfully on Core 2 Duo and Quad, and on<br=
>
Nehalem and Nehalem/Westmere where temperature readings were plausible and<=
br>
changed with load as expected. When tested on an Atom processor (N270), the=
<br>
temperature values were identical to previous versions of the coretemp<br>
module and also changed with load. However, the readings should be higher<b=
r>
by 10 to 15C as compared to the outside temperature of the processor. Huaxu=
,<br>
could you check? I would guess TjMax to be 105 instead of 90C in these<br>
processors.<br>
<br></blockquote><div><br>I apologize, if I ask a stupid question, but are =
you saying that TjMax in coretemp.c should be set to higher value than Tcas=
e-max value specified in Intel documents?<br></div></div><br>Thanks!<br>

<br>-- <br>DG<br>NJ<br><br>

--00c09ffb4eb3e26a320486d70ca9--


--===============5980680991318378332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5980680991318378332==--

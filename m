From: camden lindsay <camden.lindsay+lmsensors@gmail.com>
Date: Sat, 27 Oct 2012 18:56:52 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <CABkW7JOvWaZqqm0HBTwsOf7QbSXK=8XDUrG7VemuoOCsFeVAAw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6839189803142229476=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6839189803142229476==
Content-Type: multipart/alternative; boundary=e89a8fb201b00de70104cd0f0181

--e89a8fb201b00de70104cd0f0181
Content-Type: text/plain; charset=ISO-8859-1

>
> It appears that the board designers connected all fans to the same pwm
> output.
> Odd, but there is really no other explanation (or I don't have one).
>
> The initial pwm_enable value if "5" means that the fan control system is in
> "SmartFan IV" mode, meaning it performs automatic fan control. That mode is
> controlled with a separate register and overrides all other settings,
> meaning
> the earlier code never really changed the fan control mode at all. Which
> explains why you could not set the pwm values.
>
> Apparently, in SmartFan IV mode, you can not read the current pwm value
> with that chip.
>
> Overall I would recommend not to touch the fan control at all and leave
> pwmX_enable
> at 5. This lets the chip handle fan control, which is better than you can
> ever do
> manually.
>
> One other question: Can you change pwmX_enable back to 5, and do the fan
> speeds
> revert to the original speed if you do that ?
>
> Thanks,
> Guenter
>


Thank you, Guenter-
you are correct.  I verified the CPU fan runs when driven off of a header
with 0 PWM  (case fan header that has stopped).
Odd indeed since i bought this board because it had 4 case fan headers.

In smartfan IV mode, i can read the PWM -- i just cannot write to it.
dylan@BigBox /sys/class/hwmon/hwmon2/device $ cat pwm2 pwm2_enable pwm2_mode
11
5
1

I realize that the best way for the board and CPU would be to leave
pwmX_enable at 5, however I would also like a quiet computer, and the board
does not take into consideration the temperature of the hard drive cages.
 If i use 'whisper mode', all fans turn off but the CPU fan (by fan
hardware design, as you pointed out) and  the drives slowly start cooking.

I will have to use the 'Generic mode', which is what i was using before.

And for the final question: Yes.
If i start in 'Whisper' mode, all fans are off (exept CPU based on fan
hardware)
If i echo 1 >pwm2_enable, all fans turn on and the pwm2 sets itself to 127
If i echo 5 >pwm2_enable all fans shut back off.


Thank you very much for your time and patience.
Camden

--e89a8fb201b00de70104cd0f0181
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">It appears that t=
he board designers connected all fans to the same pwm output.<br>
Odd, but there is really no other explanation (or I don&#39;t have one).<br=
>
<br>
The initial pwm_enable value if &quot;5&quot; means that the fan control sy=
stem is in<br>
&quot;SmartFan IV&quot; mode, meaning it performs automatic fan control. Th=
at mode is<br>
controlled with a separate register and overrides all other settings, meani=
ng<br>
the earlier code never really changed the fan control mode at all. Which<br=
>
explains why you could not set the pwm values.<br>
<br>
Apparently, in SmartFan IV mode, you can not read the current pwm value<br>
with that chip.<br>
<br>
Overall I would recommend not to touch the fan control at all and leave pwm=
X_enable<br>
at 5. This lets the chip handle fan control, which is better than you can e=
ver do<br>
manually.<br>
<br>
One other question: Can you change pwmX_enable back to 5, and do the fan sp=
eeds<br>
revert to the original speed if you do that ?<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br><div><br></div><div>Thank you, Guenter-=A0</div><div=
>you are correct. =A0I verified the CPU fan runs when driven off of a heade=
r with 0 PWM =A0(case fan header that has stopped).</div><div>Odd indeed si=
nce i bought this board because it had 4 case fan headers.</div>

<div><br></div><div>In smartfan IV mode, i can read the PWM -- i just canno=
t write to it.</div><div><div>dylan@BigBox /sys/class/hwmon/hwmon2/device $=
 cat pwm2 pwm2_enable pwm2_mode</div><div>11</div><div>5</div><div>1</div>

</div><div><br></div><div>I realize that the best way for the board and CPU=
 would be to leave pwmX_enable at 5, however I would also like a quiet comp=
uter, and the board does not take into consideration the temperature of the=
 hard drive cages. =A0If i use &#39;whisper mode&#39;, all fans turn off bu=
t the CPU fan (by fan hardware design, as you pointed out) and =A0the drive=
s slowly start cooking. =A0</div>

<div><br></div><div>I will have to use the &#39;Generic mode&#39;, which is=
 what i was using before.</div><div><br></div><div>And for the final questi=
on: Yes.</div><div>If i start in &#39;Whisper&#39; mode, all fans are off (=
exept CPU based on fan hardware)</div>

<div>If i echo 1 &gt;pwm2_enable, all fans turn on and the pwm2 sets itself=
 to 127</div><div>If i echo 5 &gt;pwm2_enable all fans shut back off.</div>=
<div><br></div><div><br></div><div>Thank you very much for your time and pa=
tience.</div>

<div>Camden</div>

--e89a8fb201b00de70104cd0f0181--


--===============6839189803142229476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6839189803142229476==--

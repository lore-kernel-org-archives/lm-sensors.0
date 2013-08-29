From: Victor Severov <serverov@gmail.com>
Date: Thu, 29 Aug 2013 07:47:12 +0000
Subject: [lm-sensors] Configuration file for ASUS P8H77-I motherboard
Message-Id: <CABFd1FYhZNcVNWK-Z-BDgsgAuJrKNQqp5sWNxpp0BB18khpq5g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6755205575378384923=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============6755205575378384923==
Content-Type: multipart/alternative; boundary=047d7b2ed47f59277604e51150e5

--047d7b2ed47f59277604e51150e5
Content-Type: text/plain; charset=ISO-8859-1

Hi all!

Here is my lm-sensors config file for Asus P8H77-I motherboard. This MB
uses undocumented it8771e chip for voltage, temp and fan speed monitoring.

I hope this config may be useful to someone.
Thank you.

-- 
Best regards!
/Serverov.

-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----

# lm-sensors configuration file for the ASUS P8H77-I motherboard
# Victor Serverov <serverov <at> gmail.com>
# 29-Aug-2013
#

chip "it8771-*"

label in0 "Vcore"
label in1 "Vram"
label in2 "+12V"
label in3 "+5V"
label in4 "+3.3V"
ignore in5
ignore in6
ignore in7

compute in0 @+0.06, @-0.06
compute in2 @*(72/12), @/(72/12)
compute in3 @*(30/12), @/(30/12)
compute in4 @*(1978/1200), @/(1978/1200)

set in0_min 0.92 * 0.90
set in0_max 0.92 * 1.05
set in1_min 1.5*0.90
set in1_max 1.5 * 1.05
set in2_min 12.0 * 0.90
set in2_max 12.0 * 1.05
set in3_min 5.0 * 0.90
set in3_max 5.0 * 1.05
set in4_min 3.3 * 0.90
set in4_max 3.3 * 1.05

label fan1 "CPU Fan"
label fan2 "Chassis Fan"

label temp1 "CPU Temp"
label temp2 "M/B Temp"
ignore temp3


-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----

--047d7b2ed47f59277604e51150e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all!<br clear=3D"all"></div><div><br></div><div>He=
re is my lm-sensors config file for Asus P8H77-I motherboard. This MB uses =
undocumented it8771e chip for voltage, temp and fan speed monitoring.</div>=
<div>
<br></div><div>I hope this config may be useful to someone.</div><div>Thank=
 you.</div><div><br></div><div>
-- <br>Best regards!<br>/Serverov.
</div><div><br></div><div>-----8&lt;-----8&lt;-----8&lt;-----8&lt;-----8&lt=
;-----8&lt;-----8&lt;-----8&lt;-----

</div><div><br></div><div># lm-sensors configuration file for the ASUS P8H7=
7-I motherboard<br># Victor Serverov &lt;serverov &lt;at&gt; <a href=3D"htt=
p://gmail.com">gmail.com</a>&gt;<br># 29-Aug-2013<br>#<br><br>chip &quot;it=
8771-*&quot;<br>
<br>    label in0 &quot;Vcore&quot;<br>    label in1 &quot;Vram&quot;<br>  =
  label in2 &quot;+12V&quot;<br>    label in3 &quot;+5V&quot;<br>    label =
in4 &quot;+3.3V&quot;<br>    ignore in5<br>    ignore in6<br>    ignore in7=
<br>
<br>    compute  in0  @+0.06, @-0.06<br>    compute  in2  @*(72/12), @/(72/=
12)<br>    compute  in3  @*(30/12), @/(30/12)<br>    compute  in4  @*(1978/=
1200), @/(1978/1200)<br><br>    set in0_min 0.92 * 0.90<br>    set in0_max =
0.92 * 1.05<br>
    set in1_min 1.5*0.90<br>    set in1_max 1.5 * 1.05<br>    set in2_min 1=
2.0 * 0.90<br>    set in2_max 12.0 * 1.05<br>    set in3_min  5.0 * 0.90<br=
>    set in3_max  5.0 * 1.05<br>    set in4_min  3.3 * 0.90<br>    set in4_=
max  3.3 * 1.05<br>
<br>    label fan1 &quot;CPU Fan&quot;<br>    label fan2 &quot;Chassis Fan&=
quot;</div><div><br></div><div>  label temp1 &quot;CPU Temp&quot;<br>    la=
bel temp2 &quot;M/B Temp&quot;<br>    ignore temp3</div><div><br></div>
<div><br></div><div>
-----8&lt;-----8&lt;-----8&lt;-----8&lt;-----8&lt;-----8&lt;-----8&lt;-----=
8&lt;-----
</div><br>=A0</div>

--047d7b2ed47f59277604e51150e5--


--===============6755205575378384923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6755205575378384923==--

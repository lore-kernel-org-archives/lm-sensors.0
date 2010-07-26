From: Stephen Weatherly <steve_weatherly@yahoo.com>
Date: Mon, 26 Jul 2010 11:32:36 +0000
Subject: [lm-sensors] Possible to set up fancontrol to control 1 fan by
Message-Id: <869797.34482.qm@web24201.mail.ird.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2465430235959416583=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2465430235959416583==
Content-Type: multipart/alternative; boundary="0-2013937628-1280143956=:34482"

--0-2013937628-1280143956=:34482
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all, =0A=0AHoping someone here can help me set up fancontrol to contr=
ol a single CPU fan =0Abut monitor the temperature sensors on each of the C=
PU cores?=0A=0AI have a dual core CPU and a single CPU fan on my motherboar=
d running Ubuntu =0AServer 10.04. If I run 'sensors' I see (irrelevant deta=
ils removed):=0A=0A$ sensors=0Acoretemp-isa-0000=0AAdapter: ISA adapter=0AC=
ore 0:      +30.0=B0C  (crit =3D +100.0=B0C)=0A=0Acoretemp-isa-0001=0AAdapt=
er: ISA adapter=0ACore 1:      +33.0=B0C  (crit =3D +100.0=B0C)=0A=0Aw83627=
thf-isa-0290=0AAdapter: ISA adapter=0Afan1:        3563 RPM =0A=0A=0ANow, i=
f I run pwmconfig it correctly identifies everything and asks me if I wish =
=0Ato set up the PWM. I answer yes and it then asks me which temperature se=
nsor I =0Awant to monitor in order to control the fan.=0A=0AHere lies the p=
roblem, I can pick either of the sensors (I assume there is one =0Aon each =
core, certainly 2 are detected) but I actually want to monitor both - or =
=0Amore accurately I want to monitor whichever is hottest and control the f=
an =0Adepending on the higher value. Anyone know whether this is possible?=
=0A=0AIf I setup the pwmconfig to monitor Core 0 and control fan 1 it produ=
ces:=0A=0AINTERVAL=3D10=0ADEVPATH=3Dhwmon0=3Ddevices/platform/coretemp.0 hw=
mon2=3Ddevices/platform/w83627hf.656=0ADEVNAME=3Dhwmon0=3Dcoretemp hwmon2=
=3Dw83627thf=0AFCTEMPS=3D hwmon2/device/pwm1=3Dhwmon0/device/temp1_input=0A=
FCFANS=3D hwmon2/device/pwm1=3Dhwmon2/device/fan1_input=0AMINTEMP=3D hwmon2=
/device/pwm1=3D25=0AMAXTEMP=3D hwmon2/device/pwm1=3D35=0AMINSTART=3D hwmon2=
/device/pwm1=3D150=0AMINSTOP=3D hwmon2/device/pwm1=3D100=0A=0A=0ALooking th=
rough the documentation for fancontrol I see that you can add =0Aadditional=
 key values to each line for I added:=0Ahwmon1=3Ddevices/platform/coretemp.=
1 to DEVPATH=0Ahwmon1=3Dcoretemp to DEVNAME=0Aand then:=0Ahwmon2/device/pwm=
1=3Dhwmon1/device/temp1_input to FCTEMPS=0A=0Aso I end up with:=0A=0AINTERV=
AL=3D10=0ADEVPATH=3Dhwmon0=3Ddevices/platform/coretemp.0 hwmon1=3Ddevices/p=
latform/coretemp.1 =0Ahwmon2=3Ddevices/platform/w83627hf.656=0ADEVNAME=3Dhw=
mon0=3Dcoretemp hwmon1=3Dcoretemp hwmon2=3Dw83627thf=0AFCTEMPS=3D hwmon2/de=
vice/pwm1=3Dhwmon0/device/temp1_input =0Ahwmon2/device/pwm1=3Dhwmon1/device=
/temp1_input=0AFCFANS=3D hwmon2/device/pwm1=3Dhwmon2/device/fan1_input=0AMI=
NTEMP=3D hwmon2/device/pwm1=3D25=0AMAXTEMP=3D hwmon2/device/pwm1=3D35=0AMIN=
START=3D hwmon2/device/pwm1=3D150=0AMINSTOP=3D hwmon2/device/pwm1=3D100=0A=
=0A=0ASo, my question, is the above actually doing what I require? Listenin=
g, the fan =0Aappears to alternate sometimes (faster and slower) so I am co=
ncerned that it =0Amonitors one core and adjusts the fan, then on the next =
interval monitors the =0Asecond and adjusts the fan, and just alternates be=
tween each rather than what I =0Aactually want which is for the fan speed t=
o be determined by the hotter of the 2 =0Acores.=0A=0AAnyone have any sugge=
stions on this? Can /etc/fancontrol be modified to adjust a =0Asingle fan b=
ased on the hottest of 2 (or more) temperature sensors?=0A=0AMany thanks,=
=0ASteve=0A=0A=0A      
--0-2013937628-1280143956=:34482
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12p=
t"><div>Hello all, <br>=0A<br>=0AHoping someone here can help me set up fan=
control to control a single=0ACPU fan but monitor the temperature sensors o=
n each of the CPU cores?<br>=0A<br>=0AI have a dual core CPU and a single C=
PU fan on my motherboard running=0AUbuntu Server 10.04. If I run 'sensors' =
I see (irrelevant details=0Aremoved):<br>=0A<br>=0A$ sensors<br>=0Acoretemp=
-isa-0000<br>=0AAdapter: ISA adapter<br>=0ACore 0:      +30.0=B0C  (crit =
=3D +100.0=B0C)<br>=0A<br>=0Acoretemp-isa-0001<br>=0AAdapter: ISA adapter<b=
r>=0ACore 1:      +33.0=B0C  (crit =3D +100.0=B0C)<br>=0A<br>=0Aw83627thf-i=
sa-0290<br>=0AAdapter: ISA adapter<br>=0Afan1:        3563 RPM <br>=0A<br>=
=0A<br>=0ANow, if I run pwmconfig it correctly identifies everything and as=
ks me=0Aif I wish to set up the PWM. I answer yes and it then asks me which=
=0Atemperature sensor I want to monitor in order to control the fan.<br>=0A=
<br>=0AHere lies the problem, I can pick either of the sensors (I assume th=
ere=0Ais one on each core, certainly 2 are detected) but I actually want to=
=0Amonitor both - or more accurately I want to monitor whichever is=0Ahotte=
st and control the fan depending on the higher value. <b>Anyone know whethe=
r this is possible?</b><br>=0A<br>=0AIf I setup the pwmconfig to monitor Co=
re 0 and control fan 1 it produces:<br>=0A<br>=0AINTERVAL=3D10<br>=0ADEVPAT=
H=3Dhwmon0=3Ddevices/platform/coretemp.0 hwmon2=3Ddevices/platform/w83627hf=
.656<br>=0ADEVNAME=3Dhwmon0=3Dcoretemp hwmon2=3Dw83627thf<br>=0AFCTEMPS=3D =
hwmon2/device/pwm1=3Dhwmon0/device/temp1_input<br>=0AFCFANS=3D hwmon2/devic=
e/pwm1=3Dhwmon2/device/fan1_input<br>=0AMINTEMP=3D hwmon2/device/pwm1=3D25<=
br>=0AMAXTEMP=3D hwmon2/device/pwm1=3D35<br>=0AMINSTART=3D hwmon2/device/pw=
m1=3D150<br>=0AMINSTOP=3D hwmon2/device/pwm1=3D100<br>=0A<br>=0A<br>=0ALook=
ing through the documentation for fancontrol I see that you can add additio=
nal key values to each line for I added:<br>=0Ahwmon1=3Ddevices/platform/co=
retemp.1 to DEVPATH<br>=0Ahwmon1=3Dcoretemp to DEVNAME<br>=0Aand then:<br>=
=0Ahwmon2/device/pwm1=3Dhwmon1/device/temp1_input to FCTEMPS<br>=0A<br>=0As=
o I end up with:<br>=0A<br>=0AINTERVAL=3D10<br>=0ADEVPATH=3Dhwmon0=3Ddevice=
s/platform/coretemp.0 <b>hwmon1=3Ddevices/platform/coretemp.1</b> hwmon2=3D=
devices/platform/w83627hf.656<br>=0ADEVNAME=3Dhwmon0=3Dcoretemp <b>hwmon1=
=3Dcoretemp</b> hwmon2=3Dw83627thf<br>=0AFCTEMPS=3D hwmon2/device/pwm1=3Dhw=
mon0/device/temp1_input <b>hwmon2/device/pwm1=3Dhwmon1/device/temp1_input</=
b><br>=0AFCFANS=3D hwmon2/device/pwm1=3Dhwmon2/device/fan1_input<br>=0AMINT=
EMP=3D hwmon2/device/pwm1=3D25<br>=0AMAXTEMP=3D hwmon2/device/pwm1=3D35<br>=
=0AMINSTART=3D hwmon2/device/pwm1=3D150<br>=0AMINSTOP=3D hwmon2/device/pwm1=
=3D100<br>=0A<br>=0A<br>=0ASo, my question, is the above actually doing wha=
t I require? Listening,=0Athe fan appears to alternate sometimes (faster an=
d slower) so I am=0Aconcerned that it monitors one core and adjusts the fan=
, then on the=0Anext interval monitors the second and adjusts the fan, and =
just=0Aalternates between each rather than what I actually want which is fo=
r=0Athe fan speed to be determined by the hotter of the 2 cores.<br>=0A<br>=
=0A<b>Anyone have any suggestions on this? Can /etc/fancontrol be modified=
=0Ato adjust a single fan based on the hottest of 2 (or more) temperature=
=0Asensors?</b><br>=0A<br>=0AMany thanks,<br>=0ASteve</div>=0A</div><br>=0A=
=0A=0A=0A      </body></html>
--0-2013937628-1280143956=:34482--


--===============2465430235959416583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2465430235959416583==--

From: =?ISO-8859-1?Q?Charles_Pr=E9vot?= <charlesprevot@gmail.com>
Date: Thu, 26 Nov 2009 08:14:45 +0000
Subject: [lm-sensors] /sys/class/hwmon/ numbering
Message-Id: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5843107658058523948=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5843107658058523948==
Content-Type: multipart/alternative; boundary=00032555f9ca9f02ae047941c474

--00032555f9ca9f02ae047941c474
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I'm not sure it's the right place to ask my question, if it's not please
feel free to indicate me the post appropriate place ;)

I have some problems configuring the fancontrol script, because each time I
shutdown my computer, when I reboot my /sys/class/hwmon/ is different
(subfolders hwmon? are numbered differently).
What is responsible for this order ?
How can I configure it to have i fixed order ?

my motherboard is a Asus MN2 SLI DELUXE with AMD CPU
below some results:

$ls -l /sys/class/hwmon/hwmon?/
/sys/class/hwmon/hwmon0/:
total 0
-r--r--r-- 1 root root 4096 2009-11-26 08:30 name
drwxr-xr-x 2 root root    0 2009-11-26 08:51 power
lrwxrwxrwx 1 root root    0 2009-11-26 08:51 subsystem ->
../../../../class/hwmon
-r--r--r-- 1 root root 4096 2009-11-26 08:51 temp1_crit
-r--r--r-- 1 root root 4096 2009-11-26 08:35 temp1_input
-rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent

/sys/class/hwmon/hwmon1/:
total 0
lrwxrwxrwx 1 root root    0 2009-11-26 08:30 device -> ../../../ATK0110:00
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_input
-r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_label
-r--r--r-- 1 root root 4096 2009-11-26 08:30 fan1_max
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_min
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_input
-r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_label
-r--r--r-- 1 root root 4096 2009-11-26 08:30 fan2_max
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_min
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_input
-r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_label
-r--r--r-- 1 root root 4096 2009-11-26 08:30 fan3_max
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_min
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_input
-r--r--r-- 1 root root 4096 2009-11-26 08:27 in0_label
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_max
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_min
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_input
-r--r--r-- 1 root root 4096 2009-11-26 08:27 in1_label
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_max
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_min
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_input
-r--r--r-- 1 root root 4096 2009-11-26 08:30 in2_label
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_max
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_min
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_input
-r--r--r-- 1 root root 4096 2009-11-26 08:30 in3_label
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_max
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_min
-r--r--r-- 1 root root 4096 2009-11-26 08:30 name
drwxr-xr-x 2 root root    0 2009-11-26 08:30 power
lrwxrwxrwx 1 root root    0 2009-11-26 08:30 subsystem ->
../../../../../../../class/hwmon
-r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_crit
-r--r--r-- 1 root root 4096 2009-11-26 08:11 temp1_input
-r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_label
-r--r--r-- 1 root root 4096 2009-11-26 08:30 temp1_max
-r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_crit
-r--r--r-- 1 root root 4096 2009-11-26 08:26 temp2_input
-r--r--r-- 1 root root 4096 2009-11-26 08:33 temp2_label
-r--r--r-- 1 root root 4096 2009-11-26 08:30 temp2_max
-rw-r--r-- 1 root root 4096 2009-11-26 08:30 uevent

/sys/class/hwmon/hwmon2/:
total 0
lrwxrwxrwx 1 root root    0 2009-11-26 08:35 device -> ../../../it87.656
drwxr-xr-x 2 root root    0 2009-11-26 08:51 power
lrwxrwxrwx 1 root root    0 2009-11-26 08:51 subsystem ->
../../../../../class/hwmon
-rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent

$ cat /sys/class/hwmon/hwmon0/name
acpitz
$ cat /sys/class/hwmon/hwmon1/name
atk0110

/sys/class/hwmon/hwmon*/name

--00032555f9ca9f02ae047941c474
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>I&#39;m not sure it&#39;s the right place to ask my question, if it&=
#39;s not please feel free to indicate me the post appropriate place ;)<br>=
<br>I have some problems configuring the fancontrol script, because each ti=
me I shutdown my computer, when I reboot my /sys/class/hwmon/ is different =
(subfolders hwmon? are numbered differently). <br>
What is responsible for this order ? <br>How can I configure it to have i f=
ixed order ?<br><br>my motherboard is a <span class=3D"searchTerm">Asus</sp=
an> <span class=3D"searchTerm">MN2</span> SLI DELUXE with AMD CPU<br>below =
some results:<br>
<br>$ls -l /sys/class/hwmon/hwmon?/<br>/sys/class/hwmon/hwmon0/:<br>total 0=
<br>-r--r--r-- 1 root root 4096 2009-11-26 08:30 name<br>drwxr-xr-x 2 root =
root=A0=A0=A0 0 2009-11-26 08:51 power<br>lrwxrwxrwx 1 root root=A0=A0=A0 0=
 2009-11-26 08:51 subsystem -&gt; ../../../../class/hwmon<br>
-r--r--r-- 1 root root 4096 2009-11-26 08:51 temp1_crit<br>-r--r--r-- 1 roo=
t root 4096 2009-11-26 08:35 temp1_input<br>-rw-r--r-- 1 root root 4096 200=
9-11-26 08:51 uevent<br><br>/sys/class/hwmon/hwmon1/:<br>total 0<br>lrwxrwx=
rwx 1 root root=A0=A0=A0 0 2009-11-26 08:30 device -&gt; ../../../ATK0110:0=
0<br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_input<br>-r--r--r-- 1 roo=
t root 4096 2009-11-26 08:30 fan1_label<br>-r--r--r-- 1 root root 4096 2009=
-11-26 08:30 fan1_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan1_=
min<br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_input<br>-r--r--r-- 1 roo=
t root 4096 2009-11-26 08:30 fan2_label<br>-r--r--r-- 1 root root 4096 2009=
-11-26 08:30 fan2_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan2_=
min<br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_input<br>-r--r--r-- 1 roo=
t root 4096 2009-11-26 08:30 fan3_label<br>-r--r--r-- 1 root root 4096 2009=
-11-26 08:30 fan3_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:11 fan3_=
min<br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_input<br>-r--r--r-- 1 root=
 root 4096 2009-11-26 08:27 in0_label<br>-r--r--r-- 1 root root 4096 2009-1=
1-26 08:11 in0_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:11 in0_min<=
br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_input<br>-r--r--r-- 1 root=
 root 4096 2009-11-26 08:27 in1_label<br>-r--r--r-- 1 root root 4096 2009-1=
1-26 08:11 in1_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:11 in1_min<=
br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_input<br>-r--r--r-- 1 root=
 root 4096 2009-11-26 08:30 in2_label<br>-r--r--r-- 1 root root 4096 2009-1=
1-26 08:11 in2_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:11 in2_min<=
br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_input<br>-r--r--r-- 1 root=
 root 4096 2009-11-26 08:30 in3_label<br>-r--r--r-- 1 root root 4096 2009-1=
1-26 08:11 in3_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:11 in3_min<=
br>
-r--r--r-- 1 root root 4096 2009-11-26 08:30 name<br>drwxr-xr-x 2 root root=
=A0=A0=A0 0 2009-11-26 08:30 power<br>lrwxrwxrwx 1 root root=A0=A0=A0 0 200=
9-11-26 08:30 subsystem -&gt; ../../../../../../../class/hwmon<br>-r--r--r-=
- 1 root root 4096 2009-11-26 08:30 temp1_crit<br>
-r--r--r-- 1 root root 4096 2009-11-26 08:11 temp1_input<br>-r--r--r-- 1 ro=
ot root 4096 2009-11-26 08:30 temp1_label<br>-r--r--r-- 1 root root 4096 20=
09-11-26 08:30 temp1_max<br>-r--r--r-- 1 root root 4096 2009-11-26 08:30 te=
mp2_crit<br>
-r--r--r-- 1 root root 4096 2009-11-26 08:26 temp2_input<br>-r--r--r-- 1 ro=
ot root 4096 2009-11-26 08:33 temp2_label<br>-r--r--r-- 1 root root 4096 20=
09-11-26 08:30 temp2_max<br>-rw-r--r-- 1 root root 4096 2009-11-26 08:30 ue=
vent<br>
<br>/sys/class/hwmon/hwmon2/:<br>total 0<br>lrwxrwxrwx 1 root root=A0=A0=A0=
 0 2009-11-26 08:35 device -&gt; ../../../it87.656<br>drwxr-xr-x 2 root roo=
t=A0=A0=A0 0 2009-11-26 08:51 power<br>lrwxrwxrwx 1 root root=A0=A0=A0 0 20=
09-11-26 08:51 subsystem -&gt; ../../../../../class/hwmon<br>
-rw-r--r-- 1 root root 4096 2009-11-26 08:51 uevent<br><br>$ cat /sys/class=
/hwmon/hwmon0/name <br>acpitz<br>
$ cat /sys/class/hwmon/hwmon1/name <br>atk0110<br><br>/sys/class/hwmon/hwmo=
n*/name<br>

--00032555f9ca9f02ae047941c474--


--===============5843107658058523948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5843107658058523948==--

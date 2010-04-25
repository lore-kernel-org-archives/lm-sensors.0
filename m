From: "Mildred Ki'Lya" <mildred593@gmail.com>
Date: Sun, 25 Apr 2010 07:35:58 +0000
Subject: [lm-sensors] fancontrol EeePC,
Message-Id: <p2r64d6c631004250035lca8a4234o4787745b623460bb@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2011358669079828968=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2011358669079828968==
Content-Type: multipart/alternative; boundary=00032555623a21f8a604850ab681

--00032555623a21f8a604850ab681
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am using fancontrol for my new EeePC, and when fancontrol exit (when I
reboot for example) the fans are set to manual mode at full speed.

Aparently, the source code of fancontrol first tries to set the fan to safe
mode, and if it doesn't work, set it to manual at full speed. Apparently,
the EeePC safe mode is the same as automatic mode. So when we write "0" to
pwm1_enable, if we read it again, we'll see "2".

I could find information about EeePC fan control here:
https://patchwork.kernel.org/patch/64435/

To enable automatic mode at exit, I changed fancontrol with the following
patch:


--- /tmp/fancontrol    2010-04-25 09:31:58.394184626 +0200
+++ /usr/sbin/fancontrol    2010-04-25 09:21:24.161183983 +0200
@@ -318,7 +318,7 @@

     # Try pwmN_enable=0
     echo 0 > $ENABLE 2> /dev/null
-    if [ `cat $ENABLE` -eq 0 ]
+    if [ `cat $ENABLE` -ne 1 ]
     then
         # Success
         return 0


Do you think this change is worth including it for the next version of
lm-sensors ?

Thanks.

Mildred

PS: please Cc me for replies as I am not on the list

--00032555623a21f8a604850ab681
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am using fancontrol for my new EeePC, and when fancontrol exit=
 (when I reboot for example) the fans are set to manual mode at full speed.=
<br><br>Aparently, the source code of fancontrol first tries to set the fan=
 to safe mode, and if it doesn&#39;t work, set it to manual at full speed. =
Apparently, the EeePC safe mode is the same as automatic mode. So when we w=
rite &quot;0&quot; to pwm1_enable, if we read it again, we&#39;ll see &quot=
;2&quot;.<br>
<br>I could find information about EeePC fan control here: <a href=3D"https=
://patchwork.kernel.org/patch/64435/">https://patchwork.kernel.org/patch/64=
435/</a><br><br>To enable automatic mode at exit, I changed fancontrol with=
 the following patch:<br>
<br><br>--- /tmp/fancontrol=A0=A0=A0 2010-04-25 09:31:58.394184626 +0200<br=
>+++ /usr/sbin/fancontrol=A0=A0=A0 2010-04-25 09:21:24.161183983 +0200<br>@=
@ -318,7 +318,7 @@<br>=A0<br>=A0=A0=A0=A0 # Try pwmN_enable=3D0<br>=A0=A0=
=A0=A0 echo 0 &gt; $ENABLE 2&gt; /dev/null<br>
-=A0=A0=A0 if [ `cat $ENABLE` -eq 0 ]<br>+=A0=A0=A0 if [ `cat $ENABLE` -ne =
1 ]<br>=A0=A0=A0=A0 then<br>=A0=A0=A0=A0 =A0=A0=A0 # Success<br>=A0=A0=A0=
=A0 =A0=A0=A0 return 0<br><br><br>Do you think this change is worth includi=
ng it for the next version of lm-sensors ?<br>
<br>Thanks.<br><br>Mildred<br><br>PS: please Cc me for replies as I am not =
on the list<br><br>

--00032555623a21f8a604850ab681--


--===============2011358669079828968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2011358669079828968==--

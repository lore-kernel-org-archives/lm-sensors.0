From: Mahmood Naderan <nt_mahmood@yahoo.com>
Date: Sat, 04 Sep 2010 14:31:21 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <427980.28936.qm@web50007.mail.re2.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2547713655961990071=="
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
To: lm-sensors@vger.kernel.org

--===============2547713655961990071==
Content-Type: multipart/alternative; boundary="0-805787066-1283610681=:28936"

--0-805787066-1283610681=:28936
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>2) lm_sensors doesn't work with Ubuntu anyway, since /etc/init.d/functions=
=0A>=A0 does not exist.=0A=0AAgree with that. Another thing I found is that=
 the default locations are =0Adifferent for "installing via synaptic" and "=
installing from source". See this =0Alog:=0A=0Amahmood@lcoalhost:lm-sensors=
$sudo make install=0Amkdir -p /usr/local/lib /usr/local/include/sensors /us=
r/local/man/man3 =0A/usr/local/man/man5=0A*********************************=
*********************************************=0AWarning: This is the first =
installation of the libsensors.so.4*=0A=A0=A0=A0=A0=A0=A0=A0=A0 library fil=
es in /usr/local/lib!=0A=A0=A0=A0=A0=A0=A0=A0=A0 You must update the librar=
y cache or the userspace tools may fail=0A=A0=A0=A0=A0=A0=A0=A0=A0 or have =
unpredictable results!=0A=A0=A0=A0=A0=A0=A0=A0=A0 Run the following command=
: /sbin/ldconfig=0A********************************************************=
**********************=0Ainstall -m 644 lib/libsensors.a /usr/local/lib=0Ai=
nstall -m 755 lib/libsensors.so.4.2.1 /usr/local/lib=0Aln -sf libsensors.so=
.4.2.1 /usr/local/lib/libsensors.so.4=0Aln -sf libsensors.so.4 /usr/local/l=
ib/libsensors.so=0A********************************************************=
**********************=0AWarning: Library directory /usr/local/lib is not i=
n /etc/ld.so.conf!=0A=A0=A0=A0=A0=A0=A0=A0=A0 Add it and run /sbin/ldconfig=
 for the userspace tools to work.=0A***************************************=
***************************************=0Ainstall -m 644 lib/error.h lib/se=
nsors.h /usr/local/include/sensors=0Ainstall -m 644 lib/libsensors.3 /usr/l=
ocal/man/man3=0Ainstall -m 644 lib/sensors.conf.5 /usr/local/man/man5=0Aln =
-sf sensors.conf.5 /usr/local/man/man5/sensors3.conf.5=0Amkdir -p /usr/loca=
l/sbin /usr/local/man/man8=0Ainstall -m 755 prog/detect/sensors-detect /usr=
/local/sbin=0Ainstall -m 644 prog/detect/sensors-detect.8 /usr/local/man/ma=
n8=0Amkdir -p /usr/local/sbin /usr/local/man/man8=0Ainstall -m 755 prog/pwm=
/fancontrol prog/pwm/pwmconfig /usr/local/sbin=0Ainstall -m 644 prog/pwm/fa=
ncontrol.8 prog/pwm/pwmconfig.8 /usr/local/man/man8=0Amkdir -p /usr/local/b=
in /usr/local/man/man1=0Ainstall -m 755 prog/sensors/sensors /usr/local/bin=
=0Ainstall -m 644 prog/sensors/sensors.1 /usr/local/man/man1=0Amkdir -p /et=
c /etc/sensors.d=0Aif [ ! -e /etc/sensors3.conf ] ; then \=0A=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 install -m 644 etc/sensors.conf.default /etc/sensors3.conf =
; \=0A=A0=A0=A0=A0=A0=A0=A0 fi=0Amkdir -p /usr/local/bin=0Ainstall -m 755 e=
tc/sensors-conf-convert /usr/local/bin=0Aif [ -e /etc/modprobe.d/lm_sensors=
 \=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -a ! -e /etc/modprobe.d/lm_sensor=
s.conf ] ; then \=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0 mv -f /etc/modprobe.d/lm_se=
nsors /etc/modprobe.d/lm_sensors.conf ; \=0A=A0=A0=A0=A0=A0=A0=A0 fi=0Amkdi=
r -p /usr/local/sbin /usr/local/man/man8=0Ainstall -m 755 prog/dump/isadump=
 prog/dump/isaset /usr/local/sbin=0Ainstall -m 644 prog/dump/isadump.8 prog=
/dump/isaset.8 /usr/local/man/man8=0A*** Important notes:=0A***=A0 * The li=
bsensors configuration file (/etc/sensors3.conf) is never=0A***=A0=A0=A0 ov=
erwritten by our installation process, so that you won't lose=0A***=A0=A0=
=A0 your personal settings in that file. You still can get our latest=0A***=
=A0=A0=A0 default config file in etc/sensors.conf.default and manually copy=
=0A***=A0=A0=A0 it to /etc/sensors3.conf if you want. You will then want to=
=0A***=A0=A0=A0 edit it to fit your needs again.=0A***=A0 * The format of /=
etc/sensors3.conf changed with lm-sensors 3.0.0.=0A***=A0=A0=A0 If you have=
 a custom configuration file using the old format, you=0A***=A0=A0=A0 can c=
onvert it using the sensors-conf-convert script. Otherwise just=0A***=A0=A0=
=A0 overwrite your old configuration file with the new default one.=0A***=
=A0 * As off lm-sensors 3.1.0, the default configuration file only=0A***=A0=
=A0=A0 contains statements which do not depend on how chips are wired.=0A**=
*=A0=A0=A0 If you miss parts of the bigger configuration file that used to =
be=0A***=A0=A0=A0 the default, copy the relevant parts from etc/sensors.con=
f.eg to=0A***=A0=A0=A0 /etc/sensors3.conf.=0A=0A=A0=0A// Naderan *Mahmood;=
=0A=0A=0A=0A=0A________________________________=0AFrom: Guenter Roeck <guen=
ter.roeck@ericsson.com>=0ATo: Jean Delvare <khali@linux-fr.org>=0ACc: Mahmo=
od Naderan <nt_mahmood@yahoo.com>; lm-sensors =0A<lm-sensors@lm-sensors.org=
>=0ASent: Sat, September 4, 2010 6:55:34 PM=0ASubject: Re: [lm-sensors] lms=
ensors doesn't detect core-i7 sensors=0A=0AJean,=0A=0AOn Sat, Sep 04, 2010 =
at 09:49:42AM -0400, Jean Delvare wrote:=0A> Guenter,=0A> =0A> On Wed, 1 Se=
p 2010 07:32:25 -0700, Guenter Roeck wrote:=0A> > On Wed, Sep 01, 2010 at 0=
9:56:01AM -0400, Jean Delvare wrote:=0A> > > On Wed, 1 Sep 2010 06:26:34 -0=
700, Guenter Roeck wrote:=0A> > > > On Wed, Sep 01, 2010 at 04:16:41AM -040=
0, Mahmood Naderan wrote:=0A> > > > > >sudo /etc/init.d/lm_sensors restart=
=0A> > > > > =0A> > > > > mahmood@localhost:~$<mailto:mahmood@localhost:~$>=
 sudo =0A>/etc/init.d/lm-sensors restart=0A> > > > > .: 39: Can't open /etc=
/init.d/functions=0A> > > > > =0A> > > > > Note there is no lm_sensors. I h=
ave lm-sensors=0A> > > > > =0A> > > > =0A> > > > I tried /etc/init.d/lm-sen=
sors on a lucid (10.04) system and it works for =0A>me. It looks like=0A> >=
 > > you overwrote the original version of /etc/init.d/lm-sensors with =0A>=
prog/init.d/lm_sensors.=0A> > > > That won't work - prog/init.d/lm_sensors =
does not work with lucid. You'll =0A>need to reinstall=0A> > > > the origin=
al version of /etc/init.d/lm-sensors and try again.=0A> > > =0A> > > I prop=
osed once to delete these initialization scripts from our=0A> > > repositor=
y as they are quite distribution specific, but the few votes=0A> > > were n=
ot in my favor.=0A> > > =0A> > How about some kind of warning, or at least =
use different wording in =0A>sensors-detect ?=0A> > =0A> > The current text=
 is quite absolute ("Copy prog/init/lm_sensors.init to =0A>/etc/init.d/lm_s=
ensors")=0A> > and really invites users to overwrite the distribution speci=
fic scripts.=0A> =0A> Actually it doesn't:=0A> =0A> =A0=A0=A0 =A0=A0=A0 pri=
nt "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".=0A> =A0=A0=
=A0 =A0=A0=A0 =A0 =A0 =A0 "for initialization at boot time.\n"=0A> =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 unless -f "/etc/init.d/lm_sensors";=0A> =0A> So the=
 message isn't printed if there is already a script there.=0A> =0A> In Mahm=
ood's case, the script is named /etc/init.d/lm-sensors instead,=0A> so the =
message would be printed, but running the suggested command=0A> would _not_=
 overwrite the file. Not sure what happens where both=0A> scripts are prese=
nt though...=0A> =0AProblem is two-fold: =0A1) People will/may remove lm-se=
nsors anyway, being intelligent and assuming=0A=A0 this is what they should=
 do.=0A2) lm_sensors doesn't work with Ubuntu anyway, since /etc/init.d/fun=
ctions=0A=A0 does not exist.=0A=0A> So I would suggest that we simply exten=
d the test to:=0A> =0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 unless -f "/etc/init.=
d/lm_sensors"=0A> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 or -f "/etc/init.d/=
lm-sensors";=0A> =0A> Would that be OK with you?=0A> =0AYes.=0A=0AAnother q=
uestion is if we can get rid of the inclusion of /etc/init.d/functions.=0AI=
 browsed through the code, but don't immediately see which functions=0Aare =
used from it, and if they can be replaced. What do you think ?=0A=0A> If yo=
u have a better proposal, I'm listening. The only alternative I=0A> have in=
 mind is to get rid of the message altogether and delete the=0A> init scrip=
t from our repository, leaving integration up to each=0A> distribution (whi=
ch at least openSUSE and derivatives already do.)=0A> =0ARemoving it sounds=
 like overkill to me. After all, it _does_=0Aprovide value (when it works).=
 Maybe we should do the above,=0Aand spend some time getting it to work w/ =
Ubuntu given its=0Adistribution. I should be able to do that.=0A=0AThanks,=
=0AGuenter=0A=0A=0A=0A      
--0-805787066-1283610681=:28936
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:tahoma, new york, times, serif;font-size=
:12pt"><DIV></DIV>=0A<DIV>&gt;2) lm_sensors doesn't work with Ubuntu anyway=
, since /etc/init.d/functions<BR>&gt;&nbsp; does not exist.<BR></DIV>=0A<DI=
V>Agree with that. Another thing I found is that the default locations are =
different for "installing via synaptic" and "installing from source". See t=
his log:</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV><A href=3D"mailto:mahmood@lcoalho=
st:lm-sensors$"><FONT size=3D2 face=3D"Courier New, courier, monaco, monosp=
ace, sans-serif">mahmood@lcoalhost:lm-sensors$</FONT></A><FONT size=3D2 fac=
e=3D"Courier New, courier, monaco, monospace, sans-serif"> sudo make instal=
l<BR>mkdir -p /usr/local/lib /usr/local/include/sensors /usr/local/man/man3=
 /usr/local/man/man5<BR>***************************************************=
***************************<BR>Warning: This is the first installation of t=
he libsensors.so.4*<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lib=
rary files in /usr/local/lib!<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; You must update the library cache or the userspace tools may fail<BR=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or have unpredictable res=
ults!<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Run the following=
 command:
 /sbin/ldconfig<BR>********************************************************=
**********************<BR>install -m 644 lib/libsensors.a /usr/local/lib<BR=
>install -m 755 lib/libsensors.so.4.2.1 /usr/local/lib<BR>ln -sf libsensors=
.so.4.2.1 /usr/local/lib/libsensors.so.4<BR>ln -sf libsensors.so.4 /usr/loc=
al/lib/libsensors.so<BR>***************************************************=
***************************<BR>Warning: Library directory /usr/local/lib is=
 not in /etc/ld.so.conf!<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Add it and run /sbin/ldconfig for the userspace tools to work.<BR>*******=
***********************************************************************<BR>=
install -m 644 lib/error.h lib/sensors.h /usr/local/include/sensors<BR>inst=
all -m 644 lib/libsensors.3 /usr/local/man/man3<BR>install -m 644 lib/senso=
rs.conf.5 /usr/local/man/man5<BR>ln -sf sensors.conf.5 /usr/local/man/man5/=
sensors3.conf.5<BR>mkdir -p /usr/local/sbin
 /usr/local/man/man8<BR>install -m 755 prog/detect/sensors-detect /usr/loca=
l/sbin<BR>install -m 644 prog/detect/sensors-detect.8 /usr/local/man/man8<B=
R>mkdir -p /usr/local/sbin /usr/local/man/man8<BR>install -m 755 prog/pwm/f=
ancontrol prog/pwm/pwmconfig /usr/local/sbin<BR>install -m 644 prog/pwm/fan=
control.8 prog/pwm/pwmconfig.8 /usr/local/man/man8<BR>mkdir -p /usr/local/b=
in /usr/local/man/man1<BR>install -m 755 prog/sensors/sensors /usr/local/bi=
n<BR>install -m 644 prog/sensors/sensors.1 /usr/local/man/man1<BR>mkdir -p =
/etc /etc/sensors.d<BR>if [ ! -e /etc/sensors3.conf ] ; then \<BR>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; install -m 644 etc/sensors.co=
nf.default /etc/sensors3.conf ; \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; fi<BR>mkdir -p /usr/local/bin<BR>install -m 755 etc/sensors-conf-conve=
rt /usr/local/bin<BR>if [ -e /etc/modprobe.d/lm_sensors \<BR>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -a ! -e
 /etc/modprobe.d/lm_sensors.conf ] ; then \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mv -f /etc/modprobe.d/lm_sensors /etc/modprobe.d=
/lm_sensors.conf ; \<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<BR>mk=
dir -p /usr/local/sbin /usr/local/man/man8<BR>install -m 755 prog/dump/isad=
ump prog/dump/isaset /usr/local/sbin<BR>install -m 644 prog/dump/isadump.8 =
prog/dump/isaset.8 /usr/local/man/man8<BR>*** Important notes:<BR>***&nbsp;=
 * The libsensors configuration file (/etc/sensors3.conf) is never<BR>***&n=
bsp;&nbsp;&nbsp; overwritten by our installation process, so that you won't=
 lose<BR>***&nbsp;&nbsp;&nbsp; your personal settings in that file. You sti=
ll can get our latest<BR>***&nbsp;&nbsp;&nbsp; default config file in etc/s=
ensors.conf.default and manually copy<BR>***&nbsp;&nbsp;&nbsp; it to /etc/s=
ensors3.conf if you want. You will then want to<BR>***&nbsp;&nbsp;&nbsp; ed=
it it to fit your needs again.<BR>***&nbsp; * The format of
 /etc/sensors3.conf changed with lm-sensors 3.0.0.<BR>***&nbsp;&nbsp;&nbsp;=
 If you have a custom configuration file using the old format, you<BR>***&n=
bsp;&nbsp;&nbsp; can convert it using the sensors-conf-convert script. Othe=
rwise just<BR>***&nbsp;&nbsp;&nbsp; overwrite your old configuration file w=
ith the new default one.<BR>***&nbsp; * As off lm-sensors 3.1.0, the defaul=
t configuration file only<BR>***&nbsp;&nbsp;&nbsp; contains statements whic=
h do not depend on how chips are wired.<BR>***&nbsp;&nbsp;&nbsp; If you mis=
s parts of the bigger configuration file that used to be<BR>***&nbsp;&nbsp;=
&nbsp; the default, copy the relevant parts from etc/sensors.conf.eg to<BR>=
***&nbsp;&nbsp;&nbsp; /etc/sensors3.conf.<BR></FONT><BR>&nbsp;</DIV>=0A<DIV=
>=0A<DIV><FONT style=3D"BACKGROUND-COLOR: #ffffff" color=3D#0080ff size=3D2=
 face=3D"arial, helvetica, sans-serif"><STRONG>// Naderan *Mahmood;</STRONG=
></FONT></DIV></DIV>=0A<DIV><BR></DIV>=0A<DIV style=3D"FONT-FAMILY: tahoma,=
 new york, times, serif; FONT-SIZE: 12pt"><BR>=0A<DIV style=3D"FONT-FAMILY:=
 tahoma, new york, times, serif; FONT-SIZE: 12pt"><FONT size=3D2 face=3DTah=
oma>=0A<HR SIZE=3D1>=0A<B><SPAN style=3D"FONT-WEIGHT: bold">From:</SPAN></B=
> Guenter Roeck &lt;guenter.roeck@ericsson.com&gt;<BR><B><SPAN style=3D"FON=
T-WEIGHT: bold">To:</SPAN></B> Jean Delvare &lt;khali@linux-fr.org&gt;<BR><=
B><SPAN style=3D"FONT-WEIGHT: bold">Cc:</SPAN></B> Mahmood Naderan &lt;nt_m=
ahmood@yahoo.com&gt;; lm-sensors &lt;lm-sensors@lm-sensors.org&gt;<BR><B><S=
PAN style=3D"FONT-WEIGHT: bold">Sent:</SPAN></B> Sat, September 4, 2010 6:5=
5:34 PM<BR><B><SPAN style=3D"FONT-WEIGHT: bold">Subject:</SPAN></B> Re: [lm=
-sensors] lmsensors doesn't detect core-i7 sensors<BR></FONT><BR>Jean,<BR><=
BR>On Sat, Sep 04, 2010 at 09:49:42AM -0400, Jean Delvare wrote:<BR>&gt; Gu=
enter,<BR>&gt; <BR>&gt; On Wed, 1 Sep 2010 07:32:25 -0700, Guenter Roeck wr=
ote:<BR>&gt; &gt; On Wed, Sep 01, 2010 at 09:56:01AM -0400, Jean Delvare wr=
ote:<BR>&gt; &gt; &gt; On Wed, 1 Sep 2010 06:26:34 -0700, Guenter Roeck wro=
te:<BR>&gt; &gt; &gt; &gt; On Wed, Sep 01, 2010 at 04:16:41AM -0400, Mahmoo=
d Naderan wrote:<BR>&gt;
 &gt; &gt; &gt; &gt; &gt;sudo /etc/init.d/lm_sensors restart<BR>&gt; &gt; &=
gt; &gt; &gt; <BR>&gt; &gt; &gt; &gt; &gt; mahmood@localhost:~$&lt;mailto:m=
ahmood@localhost:~$&gt; sudo /etc/init.d/lm-sensors restart<BR>&gt; &gt; &g=
t; &gt; &gt; .: 39: Can't open /etc/init.d/functions<BR>&gt; &gt; &gt; &gt;=
 &gt; <BR>&gt; &gt; &gt; &gt; &gt; Note there is no lm_sensors. I have lm-s=
ensors<BR>&gt; &gt; &gt; &gt; &gt; <BR>&gt; &gt; &gt; &gt; <BR>&gt; &gt; &g=
t; &gt; I tried /etc/init.d/lm-sensors on a lucid (10.04) system and it wor=
ks for me. It looks like<BR>&gt; &gt; &gt; &gt; you overwrote the original =
version of /etc/init.d/lm-sensors with prog/init.d/lm_sensors.<BR>&gt; &gt;=
 &gt; &gt; That won't work - prog/init.d/lm_sensors does not work with luci=
d. You'll need to reinstall<BR>&gt; &gt; &gt; &gt; the original version of =
/etc/init.d/lm-sensors and try again.<BR>&gt; &gt; &gt; <BR>&gt; &gt; &gt; =
I proposed once to delete these initialization scripts from
 our<BR>&gt; &gt; &gt; repository as they are quite distribution specific, =
but the few votes<BR>&gt; &gt; &gt; were not in my favor.<BR>&gt; &gt; &gt;=
 <BR>&gt; &gt; How about some kind of warning, or at least use different wo=
rding in sensors-detect ?<BR>&gt; &gt; <BR>&gt; &gt; The current text is qu=
ite absolute ("Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors")<B=
R>&gt; &gt; and really invites users to overwrite the distribution specific=
 scripts.<BR>&gt; <BR>&gt; Actually it doesn't:<BR>&gt; <BR>&gt; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; print "Copy prog/init/lm_sensors.init to /etc/i=
nit.d/lm_sensors\n".<BR>&gt; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &=
nbsp; &nbsp; "for initialization at boot time.\n"<BR>&gt; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; unless -f "/etc/init.d/lm_sensors";=
<BR>&gt; <BR>&gt; So the message isn't printed if there is already a script=
 there.<BR>&gt; <BR>&gt; In Mahmood's case, the script is named
 /etc/init.d/lm-sensors instead,<BR>&gt; so the message would be printed, b=
ut running the suggested command<BR>&gt; would _not_ overwrite the file. No=
t sure what happens where both<BR>&gt; scripts are present though...<BR>&gt=
; <BR>Problem is two-fold: <BR>1) People will/may remove lm-sensors anyway,=
 being intelligent and assuming<BR>&nbsp; this is what they should do.<BR>2=
) lm_sensors doesn't work with Ubuntu anyway, since /etc/init.d/functions<B=
R>&nbsp; does not exist.<BR><BR>&gt; So I would suggest that we simply exte=
nd the test to:<BR>&gt; <BR>&gt; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; unless -f "/etc/init.d/lm_sensors"<BR>&gt; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; or -f "/etc/init.d/lm=
-sensors";<BR>&gt; <BR>&gt; Would that be OK with you?<BR>&gt; <BR>Yes.<BR>=
<BR>Another question is if we can get rid of the inclusion of /etc/init.d/f=
unctions.<BR>I browsed through the code, but don't immediately see
 which functions<BR>are used from it, and if they can be replaced. What do =
you think ?<BR><BR>&gt; If you have a better proposal, I'm listening. The o=
nly alternative I<BR>&gt; have in mind is to get rid of the message altoget=
her and delete the<BR>&gt; init script from our repository, leaving integra=
tion up to each<BR>&gt; distribution (which at least openSUSE and derivativ=
es already do.)<BR>&gt; <BR>Removing it sounds like overkill to me. After a=
ll, it _does_<BR>provide value (when it works). Maybe we should do the abov=
e,<BR>and spend some time getting it to work w/ Ubuntu given its<BR>distrib=
ution. I should be able to do that.<BR><BR>Thanks,<BR>Guenter<BR></DIV></DI=
V></div><br>=0A=0A=0A=0A=0A=0A=0A=0A      </body></html>
--0-805787066-1283610681=:28936--


--===============2547713655961990071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2547713655961990071==--

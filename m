From: DarkNovaNick@gmail.com
Date: Mon, 17 Jan 2011 23:26:03 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <90e6ba6152fc7e9920049a131bc1@google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9171087358638222419=="
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
To: lm-sensors@vger.kernel.org

--===============9171087358638222419==
Content-Type: multipart/alternative; boundary=90e6ba6152fc7e990a049a131bbe

--90e6ba6152fc7e990a049a131bbe
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

On Jan 17, 2011 4:53pm, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> On Mon, 2011-01-17 at 17:26 -0500, Anish Patel wrote:

> > On 01/17/11 16:54, Guenter Roeck wrote:

> > > On Mon, 2011-01-17 at 15:26 -0500, DarkNovaNick@gmail.com wrote:

> > >> I recently bought the new Intel Sandy Bridge processor, i5-2500k,

> > >> along with a Gigabyte GA-H67A-UD3H motherboard. I've used lm_sensors

> > >> in the past and am trying to get it to work with my new setup (on

> > >> Ubuntu 10.10 kernel 2.6.35-24). I downloaded the latest version of  
> the

> > >> sensors-detect script from the website and it was not able to find  
> any

> > >> sensors. Here is the output:

> > >>

> > >> ---------

> > >>

> > >> # sensors-detect revision 5901 (2011-01-14 17:11:54 +0100)

> > >> # System: Gigabyte Technology Co., Ltd. H67A-UD3H

> > >>

> > >> This program will help you determine which kernel modules you need

> > >> to load to use lm_sensors most effectively. It is generally safe

> > >> and recommended to accept the default answers to all questions,

> > >> unless you know what you're doing.

> > >>

> > >> Some south bridges, CPUs or memory controllers contain embedded

> > >> sensors.

> > >> Do you want to scan for them? This is totally safe. (YES/no):

> > >> Silicon Integrated Systems SIS5595... No

> > >> VIA VT82C686 Integrated Sensors... No

> > >> VIA VT8231 Integrated Sensors... No

> > >> AMD K8 thermal sensors... No

> > >> AMD Family 10h thermal sensors... No

> > >> AMD Family 11h thermal sensors... No

> > >> Intel Core family thermal sensor... No

> > >> Intel Atom thermal sensor... No

> > >> Intel AMB FB-DIMM thermal sensor... No

> > >> VIA C7 thermal sensor... No

> > >> VIA Nano thermal sensor... No

> > >>

> > >> Some Super I/O chips contain embedded sensors. We have to write to

> > >> standard I/O ports to probe them. This is usually safe.

> > >> Do you want to scan for Super I/O sensors? (YES/no):

> > >> Probing for Super-I/O at 0x2e/0x2f

> > >> Trying family `National Semiconductor'... No

> > >> Trying family `SMSC'... No

> > >> Trying family `VIA/Winbond/Nuvoton/Fintek'... No

> > >> Trying family `ITE'... Yes

> > >> Found unknown chip with ID 0x8728

> > >> (logical device 4 has address 0x290, could be sensors)

> > > The problem is more likely that the SuperIO chip used in your system  
> is

> > > not supported. If so, your problem doesn't have anything to do with

> > > SandyBridge.

> > >

> > > Guenter

> > >

> > >

> > >

> > > _______________________________________________

> > > lm-sensors mailing list

> > > lm-sensors@lm-sensors.org

> > > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

> > >

> > i think the more likely problem is that his kernel doesn't know about

> > the sandy bridge thermal diode.

> > the coretemp module probably needs an update.

> >

> The coretemp driver checks CPU registers to determine if the CPU

> supports thermal sensors or not; Sandy Bridge specific changes should

> not be necessary for this to work. Maybe it would help to simply enter

> "modprobe coretemp".



> Guenter








I just tried doing "modprobe coretemp" and then when I did "sensors" it  
seemed to output correctly. I'm not sure why I didn't think of that --  
thanks. sensors-detect still does not suggest coretemp or any other modules  
to load though. Thanks,

Nick

--90e6ba6152fc7e990a049a131bbe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Jan 17, 2011 4:53pm, Guenter Roeck &lt;guenter.roeck@ericsson.com&gt; wr=
ote:<br />&gt; On Mon, 2011-01-17 at 17:26 -0500, Anish Patel wrote:<br />&=
gt; <br />&gt; &gt; On 01/17/11 16:54, Guenter Roeck wrote:<br />&gt; <br /=
>&gt; &gt; &gt; On Mon, 2011-01-17 at 15:26 -0500, DarkNovaNick@gmail.com w=
rote:<br />&gt; <br />&gt; &gt; &gt;&gt; I recently bought the new Intel Sa=
ndy Bridge processor, i5-2500k,<br />&gt; <br />&gt; &gt; &gt;&gt; along wi=
th a Gigabyte GA-H67A-UD3H motherboard. I&#39;ve used lm_sensors<br />&gt; =
<br />&gt; &gt; &gt;&gt; in the past and am trying to get it to work with m=
y new setup (on<br />&gt; <br />&gt; &gt; &gt;&gt; Ubuntu 10.10 kernel 2.6.=
35-24). I downloaded the latest version of the<br />&gt; <br />&gt; &gt; &g=
t;&gt; sensors-detect script from the website and it was not able to find a=
ny<br />&gt; <br />&gt; &gt; &gt;&gt; sensors. Here is the output:<br />&gt=
; <br />&gt; &gt; &gt;&gt;<br />&gt; <br />&gt; &gt; &gt;&gt; ---------<br =
/>&gt; <br />&gt; &gt; &gt;&gt;<br />&gt; <br />&gt; &gt; &gt;&gt; # sensor=
s-detect revision 5901 (2011-01-14 17:11:54 +0100)<br />&gt; <br />&gt; &gt=
; &gt;&gt; # System: Gigabyte Technology Co., Ltd. H67A-UD3H<br />&gt; <br =
/>&gt; &gt; &gt;&gt;<br />&gt; <br />&gt; &gt; &gt;&gt; This program will h=
elp you determine which kernel modules you need<br />&gt; <br />&gt; &gt; &=
gt;&gt; to load to use lm_sensors most effectively. It is generally safe<br=
 />&gt; <br />&gt; &gt; &gt;&gt; and recommended to accept the default answ=
ers to all questions,<br />&gt; <br />&gt; &gt; &gt;&gt; unless you know wh=
at you&#39;re doing.<br />&gt; <br />&gt; &gt; &gt;&gt;<br />&gt; <br />&gt=
; &gt; &gt;&gt; Some south bridges, CPUs or memory controllers contain embe=
dded<br />&gt; <br />&gt; &gt; &gt;&gt; sensors.<br />&gt; <br />&gt; &gt; =
&gt;&gt; Do you want to scan for them? This is totally safe. (YES/no):<br /=
>&gt; <br />&gt; &gt; &gt;&gt; Silicon Integrated Systems SIS5595... No<br =
/>&gt; <br />&gt; &gt; &gt;&gt; VIA VT82C686 Integrated Sensors... No<br />=
&gt; <br />&gt; &gt; &gt;&gt; VIA VT8231 Integrated Sensors... No<br />&gt;=
 <br />&gt; &gt; &gt;&gt; AMD K8 thermal sensors... No<br />&gt; <br />&gt;=
 &gt; &gt;&gt; AMD Family 10h thermal sensors... No<br />&gt; <br />&gt; &g=
t; &gt;&gt; AMD Family 11h thermal sensors... No<br />&gt; <br />&gt; &gt; =
&gt;&gt; Intel Core family thermal sensor... No<br />&gt; <br />&gt; &gt; &=
gt;&gt; Intel Atom thermal sensor... No<br />&gt; <br />&gt; &gt; &gt;&gt; =
Intel AMB FB-DIMM thermal sensor... No<br />&gt; <br />&gt; &gt; &gt;&gt; V=
IA C7 thermal sensor... No<br />&gt; <br />&gt; &gt; &gt;&gt; VIA Nano ther=
mal sensor... No<br />&gt; <br />&gt; &gt; &gt;&gt;<br />&gt; <br />&gt; &g=
t; &gt;&gt; Some Super I/O chips contain embedded sensors. We have to write=
 to<br />&gt; <br />&gt; &gt; &gt;&gt; standard I/O ports to probe them. Th=
is is usually safe.<br />&gt; <br />&gt; &gt; &gt;&gt; Do you want to scan =
for Super I/O sensors? (YES/no):<br />&gt; <br />&gt; &gt; &gt;&gt; Probing=
 for Super-I/O at 0x2e/0x2f<br />&gt; <br />&gt; &gt; &gt;&gt; Trying famil=
y `National Semiconductor&#39;... No<br />&gt; <br />&gt; &gt; &gt;&gt; Try=
ing family `SMSC&#39;... No<br />&gt; <br />&gt; &gt; &gt;&gt; Trying famil=
y `VIA/Winbond/Nuvoton/Fintek&#39;... No<br />&gt; <br />&gt; &gt; &gt;&gt;=
 Trying family `ITE&#39;... Yes<br />&gt; <br />&gt; &gt; &gt;&gt; Found un=
known chip with ID 0x8728<br />&gt; <br />&gt; &gt; &gt;&gt; (logical devic=
e 4 has address 0x290, could be sensors)<br />&gt; <br />&gt; &gt; &gt; The=
 problem is more likely that the SuperIO chip used in your system is<br />&=
gt; <br />&gt; &gt; &gt; not supported. If so, your problem doesn&#39;t hav=
e anything to do with<br />&gt; <br />&gt; &gt; &gt; SandyBridge.<br />&gt;=
 <br />&gt; &gt; &gt;<br />&gt; <br />&gt; &gt; &gt; Guenter<br />&gt; <br =
/>&gt; &gt; &gt;<br />&gt; <br />&gt; &gt; &gt;<br />&gt; <br />&gt; &gt; &=
gt;<br />&gt; <br />&gt; &gt; &gt; ________________________________________=
_______<br />&gt; <br />&gt; &gt; &gt; lm-sensors mailing list<br />&gt; <b=
r />&gt; &gt; &gt; lm-sensors@lm-sensors.org<br />&gt; <br />&gt; &gt; &gt;=
 http://lists.lm-sensors.org/mailman/listinfo/lm-sensors<br />&gt; <br />&g=
t; &gt; &gt;<br />&gt; <br />&gt; &gt; i think the more likely problem is t=
hat his kernel doesn&#39;t know about<br />&gt; <br />&gt; &gt; the sandy b=
ridge thermal diode.<br />&gt; <br />&gt; &gt; the coretemp module probably=
 needs an update.<br />&gt; <br />&gt; &gt;<br />&gt; <br />&gt; The corete=
mp driver checks CPU registers to determine if the CPU<br />&gt; <br />&gt;=
 supports thermal sensors or not; Sandy Bridge specific changes should<br /=
>&gt; <br />&gt; not be necessary for this to work. Maybe it would help to =
simply enter<br />&gt; <br />&gt; &quot;modprobe coretemp&quot;.<br />&gt; =
<br />&gt; <br />&gt; <br />&gt; Guenter<br />&gt; <br />&gt; <br />&gt; <b=
r />&gt; <br />&gt; <br />&gt; <br /><br /><br />I just tried doing &quot;m=
odprobe coretemp&quot; and then when I did &quot;sensors&quot; it seemed to=
 output correctly. I&#39;m not sure why I didn&#39;t think of that -- thank=
s. sensors-detect still does not suggest coretemp or any other modules to l=
oad though. Thanks,<br /><br />Nick
--90e6ba6152fc7e990a049a131bbe--


--===============9171087358638222419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9171087358638222419==--

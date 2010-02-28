From: Josu Lazkano <josu.lazkano@gmail.com>
Date: Sun, 28 Feb 2010 22:07:20 +0000
Subject: Re: [lm-sensors] HP Compaq nx8220
Message-Id: <3907abe61002281407w701c4523h33ef7179246759c@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6382980119079913564=="
List-Id: <lm-sensors.vger.kernel.org>
References: <3907abe61002231703y34ec6f2em79f0831c7fce4484@mail.gmail.com>
In-Reply-To: <3907abe61002231703y34ec6f2em79f0831c7fce4484@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6382980119079913564==
Content-Type: multipart/alternative; boundary=0016e6dab4b64995150480b05be9

--0016e6dab4b64995150480b05be9
Content-Type: text/plain; charset=ISO-8859-1

OK, thanks for your reply. This is the "lspci" output:

$ lspci
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Processor to DRAM Controller (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express
Root Port (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 2 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) AC'97 Audio Controller (rev 03)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97
Modem Controller (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge
(rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
IDE Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc M24 1P [Radeon
Mobility X600]
02:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG
[Calexico2] Network Connection (rev 05)
02:06.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
02:06.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller
02:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
02:06.4 SD Host controller: Texas Instruments
PCI6411/6421/6611/6621/7411/7421/7611/7621 Secure Digital Controller
02:06.5 Communication controller: Texas Instruments
PCI6411/6421/6611/6621/7411/7421/7611/7621 Smart Card Controller
10:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit
Ethernet PCI Express (rev 11)

Thanks for all!



2010/2/28 Juerg Haefliger <juergh@gmail.com>

> Hi Josu,
>
>
> > Hello, I have a HP Compaq nx8220 laptop with Debian Lenny.
> >
> > I want know the processor temp from lm-sensors. I installed and it has
> not
> > found any device.
> >
> > Is my device supported?
>
> Sorry if I sound rude but how can you expect support if you don't
> supply any information? Are we supposed to guess what devices your
> laptop contains?
>
> Please read the FAQ http://www.lm-sensors.org/wiki/FAQ/Chapter4
>
> ...juerg
>
>
> > Thanks for all and best regards.
> >
> > --
> > Josu Lazkano
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >
>



-- 
Josu Lazkano

--0016e6dab4b64995150480b05be9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

OK, thanks for your reply. This is the &quot;lspci&quot; output:<br><br>$ l=
spci <br>00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML =
Express Processor to DRAM Controller (rev 03)<br>00:01.0 PCI bridge: Intel =
Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03)<br>
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) P=
CI Express Port 1 (rev 03)<br>00:1c.1 PCI bridge: Intel Corporation 82801FB=
/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03)<br>00:1d.0 USB Con=
troller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 =
(rev 03)<br>
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Famil=
y) USB UHCI #2 (rev 03)<br>00:1d.2 USB Controller: Intel Corporation 82801F=
B/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)<br>00:1d.7 USB Controlle=
r: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controll=
er (rev 03)<br>
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)<br>0=
0:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW=
 (ICH6 Family) AC&#39;97 Audio Controller (rev 03)<br>00:1e.3 Modem: Intel =
Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC&#39;97 Modem Controller =
(rev 03)<br>
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge=
 (rev 03)<br>00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW=
 (ICH6 Family) IDE Controller (rev 03)<br>01:00.0 VGA compatible controller=
: ATI Technologies Inc M24 1P [Radeon Mobility X600]<br>
02:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG [Calexico=
2] Network Connection (rev 05)<br>02:06.0 CardBus bridge: Texas Instruments=
 PCIxx21/x515 Cardbus Controller<br>02:06.2 FireWire (IEEE 1394): Texas Ins=
truments OHCI Compliant IEEE 1394 Host Controller<br>
02:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated Flash=
Media Controller<br>02:06.4 SD Host controller: Texas Instruments PCI6411/6=
421/6611/6621/7411/7421/7611/7621 Secure Digital Controller<br>02:06.5 Comm=
unication controller: Texas Instruments PCI6411/6421/6611/6621/7411/7421/76=
11/7621 Smart Card Controller<br>
10:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabi=
t Ethernet PCI Express (rev 11)<br><br>Thanks for all!<br><br><br><br><div =
class=3D"gmail_quote">2010/2/28 Juerg Haefliger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:juergh@gmail.com">juergh@gmail.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Josu,<br>
<div class=3D"im"><br>
<br>
&gt; Hello, I have a HP Compaq nx8220 laptop with Debian Lenny.<br>
&gt;<br>
&gt; I want know the processor temp from lm-sensors. I installed and it has=
 not<br>
&gt; found any device.<br>
&gt;<br>
&gt; Is my device supported?<br>
<br>
</div>Sorry if I sound rude but how can you expect support if you don&#39;t=
<br>
supply any information? Are we supposed to guess what devices your<br>
laptop contains?<br>
<br>
Please read the FAQ <a href=3D"http://www.lm-sensors.org/wiki/FAQ/Chapter4"=
 target=3D"_blank">http://www.lm-sensors.org/wiki/FAQ/Chapter4</a><br>
<br>
...juerg<br>
<div class=3D"im"><br>
<br>
&gt; Thanks for all and best regards.<br>
&gt;<br>
&gt; --<br>
&gt; Josu Lazkano<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; lm-sensors mailing list<br>
&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org=
</a><br>
&gt; <a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" ta=
rget=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a>=
<br>
&gt;<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Josu Lazkano<br>

--0016e6dab4b64995150480b05be9--


--===============6382980119079913564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6382980119079913564==--

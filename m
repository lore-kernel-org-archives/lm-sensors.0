From: "Dean Loros" <autocrosser1@gmail.com>
Date: Tue, 09 Sep 2008 19:29:41 +0000
Subject: Re: [lm-sensors] i2c output info
Message-Id: <2f1459c40809091229u5d8a3e6dxd28e6ed620203f3@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3488268728539356851=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20080909180856.5cf2c123@hyperion.delvare>
In-Reply-To: <20080909180856.5cf2c123@hyperion.delvare>
To: lm-sensors@vger.kernel.org

--===============3488268728539356851==
Content-Type: multipart/alternative; 
	boundary="----=_Part_15810_9843008.1220988581594"

------=_Part_15810_9843008.1220988581594
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Sep 9, 2008 at 9:08 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Dean,
>
> Please keep the lm-sensors list Cc'd.
>
> On Mon, 08 Sep 2008 19:00:52 -0700, Dean Loros wrote:
> > Hi Jean--
> >
> > I've identified AUX fan as my front intake fan, fan4 as my rear exhaust
> > fan, CPU fan is correct & Case fan is running one of my two video card
> > fans. The motherboard has 6 fan connections, so I would assume that
> > there is another chip running at least one fan connector & as I can't
> > see the other video card--I would guess that the w83627ehf runs four
> > outputs?
>
> I would be surprised if the W83627DHG can actually monitor your video
> card's fan. For that, the fan in question would have to be connected to
> the motherboard rather than the video card it cools. This seems
> unlikely.


I use Zalman 3 wire fans that are not connected to the cards--both are
connected to the motherboard & that's one of my problems--I am using all six
of the motherboard connectors & getting reports on only four. I suspect that
I'm not seeing either of them--unless the 3000 from fan2 is one.

>
>
> It is indeed possible that there's another monitoring chip on your
> motherboard. Also, I have checked sensors-detect and the changes I
> wanted to make to prevent the misdetection you experienced, happens to
> be done there already. This make me suspect that you have been running
> an old version of sensors-detect. Could you please try the latest
> version?
>
> http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt


Interesting--I am using what is available in the latest version of
Ubuntu--8.10 testing--Looks like I might raise a bugreport about this--I'm
not at my system right now (at work), but I see that it is version
3.02?---not sure of the sub-number. Will download/install your version after
I look at the #'s for reporting reasons.

>
>
> Unload the hardware monitoring drivers before running it. It should no
> longer suggest that you load the lm78 driver. And maybe it will see
> another monitoring chip.


Will do this evening.

>
>
> >
> > The nForce SPP Fan speed I can only see in the BIOS--don't know where
> > it's speed is--
> >
> > Any more info you need?
> >
> > Terminal data follows:
> >
> > dean@linux:~/Desktop$ sudo rmmod w83627ehf
> > [sudo] password for dean:
> > dean@linux:~/Desktop$ sudo modprobe i2c-dev
> > dean@linux:~/Desktop$ sudo isadump 0x295 0x296
> > WARNING! Running this program can cause system crashes, data loss and
> worse!
> > I will probe address register 0x295 and data register 0x296.
> > Continue? [Y/n] y
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a
> > 10: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c0
> > 20: a0 82 d0 d0 a0 c2 e5 5a e0 20 9a cb 88 cb 74 d9
> > 30: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68
> > 40: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3
> > 50: 25 00 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff
> > 60: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a
> > 90: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c0
> > a0: a0 82 d0 d0 a0 c2 e5 5a e0 20 9a cb 88 cb 74 d9
> > b0: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68
> > c0: 01 00 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3
> > d0: 25 00 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff
> > e0: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > dean@linux:~/Desktop$ sudo i2cdump 1 0x2d b
> > WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> > I will probe file /dev/i2c-1, address 0x2d, mode byte
> > Continue? [Y/n] y
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a    ?.?@1.?P????<<??
> > 10: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff d8    ??P..??<C?.....?
> > 20: a0 83 d0 d0 a0 c2 e6 5a e1 21 99 cb 88 cb 74 d9    ???????Z?!????t?
> > 30: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68    ?.?.?...?.??T??h
> > 40: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3    ???...??-.@?????
> > 50: 24 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff    $??..???........
> > 60: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff    ?@3???<.?.?.....
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 80: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a    ?.?@1.?P????<<??
> > 90: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c6    ??P..??<C?.....?
> > a0: a0 83 d0 d0 a0 c2 e5 5a e0 20 99 cb 88 cb 74 d9    ???????Z? ????t?
> > b0: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 67    ?.?.?...?.??T??g
> > c0: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3    ???...??-.@?????
> > d0: 24 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff    $??..???........
> > e0: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff    ?@3???<.?.?.....
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
>
> I guess you will trust me that both dumps correspond to the same
> device. All register values are the same.
>
> --
> Jean Delvare
>

------=_Part_15810_9843008.1220988581594
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><br><br><div class="gmail_quote">On Tue, Sep 9, 2008 at 9:08 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Dean,<br>
<br>
Please keep the lm-sensors list Cc&#39;d.<br>
<div class="Ih2E3d"><br>
On Mon, 08 Sep 2008 19:00:52 -0700, Dean Loros wrote:<br>
&gt; Hi Jean--<br>
&gt;<br>
&gt; I&#39;ve identified AUX fan as my front intake fan, fan4 as my rear exhaust<br>
&gt; fan, CPU fan is correct &amp; Case fan is running one of my two video card<br>
&gt; fans. The motherboard has 6 fan connections, so I would assume that<br>
&gt; there is another chip running at least one fan connector &amp; as I can&#39;t<br>
&gt; see the other video card--I would guess that the w83627ehf runs four<br>
&gt; outputs?<br>
<br>
</div>I would be surprised if the W83627DHG can actually monitor your video<br>
card&#39;s fan. For that, the fan in question would have to be connected to<br>
the motherboard rather than the video card it cools. This seems<br>
unlikely.</blockquote><div><br>I use Zalman 3 wire fans that are not connected to the cards--both are connected to the motherboard &amp; that&#39;s one of my problems--I am using all six of the motherboard connectors &amp; getting reports on only four. I suspect that I&#39;m not seeing either of them--unless the 3000 from fan2 is one.<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
It is indeed possible that there&#39;s another monitoring chip on your<br>
motherboard. Also, I have checked sensors-detect and the changes I<br>
wanted to make to prevent the misdetection you experienced, happens to<br>
be done there already. This make me suspect that you have been running<br>
an old version of sensors-detect. Could you please try the latest<br>
version?<br>
<a href="http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt" target="_blank">http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=txt</a></blockquote>
<div><br>Interesting--I am using what is available in the latest version of Ubuntu--8.10 testing--Looks like I might raise a bugreport about this--I&#39;m not at my system right now (at work), but I see that it is version 3.02?---not sure of the sub-number. Will download/install your version after I look at the #&#39;s for reporting reasons.<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Unload the hardware monitoring drivers before running it. It should no<br>
longer suggest that you load the lm78 driver. And maybe it will see<br>
another monitoring chip.</blockquote><div><br>Will do this evening. <br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div><div></div><div class="Wj3C7c"><br>
&gt;<br>
&gt; The nForce SPP Fan speed I can only see in the BIOS--don&#39;t know where<br>
&gt; it&#39;s speed is--<br>
&gt;<br>
&gt; Any more info you need?<br>
&gt;<br>
&gt; Terminal data follows:<br>
&gt;<br>
&gt; dean@linux:~/Desktop$ sudo rmmod w83627ehf<br>
&gt; [sudo] password for dean:<br>
&gt; dean@linux:~/Desktop$ sudo modprobe i2c-dev<br>
&gt; dean@linux:~/Desktop$ sudo isadump 0x295 0x296<br>
&gt; WARNING! Running this program can cause system crashes, data loss and worse!<br>
&gt; I will probe address register 0x295 and data register 0x296.<br>
&gt; Continue? [Y/n] y<br>
&gt; &nbsp; &nbsp; &nbsp;0 &nbsp;1 &nbsp;2 &nbsp;3 &nbsp;4 &nbsp;5 &nbsp;6 &nbsp;7 &nbsp;8 &nbsp;9 &nbsp;a &nbsp;b &nbsp;c &nbsp;d &nbsp;e &nbsp;f<br>
&gt; 00: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a<br>
&gt; 10: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c0<br>
&gt; 20: a0 82 d0 d0 a0 c2 e5 5a e0 20 9a cb 88 cb 74 d9<br>
&gt; 30: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68<br>
&gt; 40: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3<br>
&gt; 50: 25 00 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff<br>
&gt; 60: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff<br>
&gt; 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff<br>
&gt; 80: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a<br>
&gt; 90: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c0<br>
&gt; a0: a0 82 d0 d0 a0 c2 e5 5a e0 20 9a cb 88 cb 74 d9<br>
&gt; b0: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68<br>
&gt; c0: 01 00 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3<br>
&gt; d0: 25 00 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff<br>
&gt; e0: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff<br>
&gt; f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff<br>
&gt; dean@linux:~/Desktop$ sudo i2cdump 1 0x2d b<br>
&gt; WARNING! This program can confuse your I2C bus, cause data loss and worse!<br>
&gt; I will probe file /dev/i2c-1, address 0x2d, mode byte<br>
&gt; Continue? [Y/n] y<br>
&gt; &nbsp; &nbsp; &nbsp;0 &nbsp;1 &nbsp;2 &nbsp;3 &nbsp;4 &nbsp;5 &nbsp;6 &nbsp;7 &nbsp;8 &nbsp;9 &nbsp;a &nbsp;b &nbsp;c &nbsp;d &nbsp;e &nbsp;f &nbsp; &nbsp;0123456789abcdef<br>
&gt; 00: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a &nbsp; &nbsp;?.?@1.?P????&lt;&lt;??<br>
&gt; 10: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff d8 &nbsp; &nbsp;??P..??&lt;C?.....?<br>
&gt; 20: a0 83 d0 d0 a0 c2 e6 5a e1 21 99 cb 88 cb 74 d9 &nbsp; &nbsp;???????Z?!????t?<br>
&gt; 30: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 68 &nbsp; &nbsp;?.?.?...?.??T??h<br>
&gt; 40: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3 &nbsp; &nbsp;???...??-.@?????<br>
&gt; 50: 24 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff &nbsp; &nbsp;$??..???........<br>
&gt; 60: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff &nbsp; &nbsp;?@3???&lt;.?.?.....<br>
&gt; 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 80: 04 ff 04 40 31 00 1e 50 01 02 01 02 3c 3c 0a 0a &nbsp; &nbsp;?.?@1.?P????&lt;&lt;??<br>
&gt; 90: 04 01 50 00 00 01 01 3c 43 07 00 00 ff ff ff c6 &nbsp; &nbsp;??P..??&lt;C?.....?<br>
&gt; a0: a0 83 d0 d0 a0 c2 e5 5a e0 20 99 cb 88 cb 74 d9 &nbsp; &nbsp;???????Z? ????t?<br>
&gt; b0: 90 ff db ff fe 00 00 00 01 00 7f fe 54 0f b9 67 &nbsp; &nbsp;?.?.?...?.??T??g<br>
&gt; c0: 01 10 10 ff ff ff 07 15 2d 00 40 c4 18 15 01 a3 &nbsp; &nbsp;???...??-.@?????<br>
&gt; d0: 24 80 02 00 00 7f 05 e0 ff ff ff ff ff ff ff ff &nbsp; &nbsp;$??..???........<br>
&gt; e0: 04 40 33 1e 02 02 3c ff 1f ff 1f ff ff ff ff ff &nbsp; &nbsp;?@3???&lt;.?.?.....<br>
&gt; f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
<br>
</div></div>I guess you will trust me that both dumps correspond to the same<br>
device. All register values are the same.<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br></div>

------=_Part_15810_9843008.1220988581594--


--===============3488268728539356851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3488268728539356851==--

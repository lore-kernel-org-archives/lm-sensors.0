From: "Anthony Arobone" <aaroboneml@gmail.com>
Date: Fri, 26 Sep 2008 17:19:31 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <7bccedf10809261019u677dbc8bl6845e3a6ead27b71@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0844428435829116287=="
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0844428435829116287==
Content-Type: multipart/alternative; 
	boundary="----=_Part_15445_14220428.1222449571255"

------=_Part_15445_14220428.1222449571255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jena,  thanks a lot for your help.

My BIOS does display all the correct values for temps and voltage for
everything.


On Fri, Sep 26, 2008 at 4:42 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi again Anthony,
>
> On Thu, 25 Sep 2008 17:13:17 -0700, Anthony Arobone wrote:
> > Finally got the board all hooked up again.  I've attached a text file
> with
> > all the output I could think of.  Notice the dmesg warning when
> modprobing
> > lm85.
>

>
> Can you please provide a dump of your chip? You should be able to get
> it the following way:
>
> # rmmod lm85
> # modprobe i2c-dev
> # i2cdump 0 0x2e b
>

I have i2c-dev built into kernel. Hope that's not a problem.

# i2cdump 0 0x2e b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x2e, mode byte
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff    ................
30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 01 68    ..............?h
40: 04 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c4    ????........bbb?
60: c4 c4 00 00 80 80 80 00 00 00 64 64 64 44 44 a4    ??..???...dddDD?
70: ff ff ff 00 00 00 08 00 00 22 6e 6e 6e 00 00 00    ......?.."nnn...
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00    ........?.......

------=_Part_15445_14220428.1222449571255
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Jena,&nbsp; thanks a lot for your help.<br><br>My BIOS does display all the correct values for temps and voltage for everything.<br>
<br><br><div class="gmail_quote">On Fri, Sep 26, 2008 at 4:42 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi again Anthony,<br>
<div class="Ih2E3d"><br>
On Thu, 25 Sep 2008 17:13:17 -0700, Anthony Arobone wrote:<br>
</div><div>&gt; Finally got the board all hooked up again. &nbsp;I&#39;ve attached a text file with<br>
&gt; all the output I could think of. &nbsp;Notice the dmesg warning when modprobing<br>
&gt; lm85. <br></div></blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d"><br>
<br>
</div>Can you please provide a dump of your chip? You should be able to get<br>
it the following way:<br>
<br>
# rmmod lm85<br>
# modprobe i2c-dev<br>
# i2cdump 0 0x2e b<br>
</blockquote><div><br>I have i2c-dev built into kernel. Hope that&#39;s not a problem.<br><br># i2cdump 0 0x2e b<br>WARNING! This program can confuse your I2C bus, cause data loss and worse!<br>I will probe file /dev/i2c/0, address 0x2e, mode byte<br>
Continue? [Y/n] Y<br>&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5&nbsp; 6&nbsp; 7&nbsp; 8&nbsp; 9&nbsp; a&nbsp; b&nbsp; c&nbsp; d&nbsp; e&nbsp; f&nbsp;&nbsp;&nbsp; 0123456789abcdef<br>00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>
20: 00 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff&nbsp;&nbsp;&nbsp; ................<br>30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 01 68&nbsp;&nbsp;&nbsp; ..............?h<br>40: 04 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f&nbsp;&nbsp;&nbsp; ?.............??<br>
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c4&nbsp;&nbsp;&nbsp; ????........bbb?<br>60: c4 c4 00 00 80 80 80 00 00 00 64 64 64 44 44 a4&nbsp;&nbsp;&nbsp; ??..???...dddDD?<br>70: ff ff ff 00 00 00 08 00 00 22 6e 6e 6e 00 00 00&nbsp;&nbsp;&nbsp; ......?..&quot;nnn...<br>
80: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ?...............<br>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<br>f0: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ........?.......<br><br></div></div><br></div>

------=_Part_15445_14220428.1222449571255--


--===============0844428435829116287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0844428435829116287==--

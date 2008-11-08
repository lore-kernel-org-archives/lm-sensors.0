From: "Anthony Arobone" <aaroboneml@gmail.com>
Date: Sat, 08 Nov 2008 01:38:00 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <7bccedf10811071738k41f9a7b9jf568f07451a80f0a@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7350181028162310226=="
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7350181028162310226==
Content-Type: multipart/alternative; 
	boundary="----=_Part_51285_1246850.1226108281011"

------=_Part_51285_1246850.1226108281011
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Oct 29, 2008 at 3:43 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Anthony,
>
> On Tue, 21 Oct 2008 12:06:43 -0700, Anthony Arobone wrote:
> > Would the tech docs on this sensor be helpful?  I found them on the Intel
> > site.  It describes all the registers in detail.
> >
> > See Chapter 23.
> > http://www.intel.com/Assets/PDF/datasheet/319973.pdf
>
> This is the ICH10 (south bridge) datasheet. The ICH10 does indeed
> include sensors for temperature and fans, but we don't support them.
> And I doubt that's what your board uses though, as your BIOS also
> displays voltage values while I don't think the ICH10 has voltage
> sensors.
>
> > Let me know if I can do any debugging or coding to help out.  I'm
> proficient
> > in C and C++.  Just don't understand how all this sensor stuff works ;)
>
> I just had a new idea. All users who reported the mysterious all-zero
> LM96000 chip also have a PC8374L or compatible super-I/O chip. I am
> almost certain that what sensors-detect identifies as an LM96000 is
> actually the PC8374L super-I/O chip, as it is documented as exposing
> its hardware monitoring registers on the SMBus.
>
> Please provide a dump of the logical device 8 of your Super-I/O:
>
> isadump 0x2e 0x2f 8
>


# isadump 0x2e 0x2f 8
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 8 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41
20: f1 01 00 00 01 01 00 91 00 11 2e 00 00 10 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


So I was looking into this a little more and I came across an Intel driver
called HECI.  I guess it was submitted to the linux kernel, but hasn't made
it in yet.  At any rate, I downloaded it and some other goodies from
http://www.openamt.org/.  In short, I tweaked a few places to get it to
compile and load for my kernel, 2.6.27 (actually on .28-rc3 now).  But I
think this is the new way to access all the Intel sensors, etc.  I don't
know much about it yet, looks like it can do alot.  But I didn't see a way
to get the temp assets from any of the examples, and I don't think I'll have
anymore time to look into this further.

Thanks for all your help though, but I think you are right.  Accessing the
temps via the tradional drivers (for lack of better word) is never going to
happen.  I think its going to be through this HECI driver, but it looks like
whatever support was being put into that has flat lined.

Thanks again

------=_Part_51285_1246850.1226108281011
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div class="gmail_quote">On Wed, Oct 29, 2008 at 3:43 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Anthony,<br>
<div class="Ih2E3d"><br>
On Tue, 21 Oct 2008 12:06:43 -0700, Anthony Arobone wrote:<br>
&gt; Would the tech docs on this sensor be helpful? &nbsp;I found them on the Intel<br>
&gt; site. &nbsp;It describes all the registers in detail.<br>
&gt;<br>
&gt; See Chapter 23.<br>
&gt; <a href="http://www.intel.com/Assets/PDF/datasheet/319973.pdf" target="_blank">http://www.intel.com/Assets/PDF/datasheet/319973.pdf</a><br>
<br>
</div>This is the ICH10 (south bridge) datasheet. The ICH10 does indeed<br>
include sensors for temperature and fans, but we don&#39;t support them.<br>
And I doubt that&#39;s what your board uses though, as your BIOS also<br>
displays voltage values while I don&#39;t think the ICH10 has voltage<br>
sensors.<br>
<div class="Ih2E3d"><br>
&gt; Let me know if I can do any debugging or coding to help out. &nbsp;I&#39;m proficient<br>
&gt; in C and C++. &nbsp;Just don&#39;t understand how all this sensor stuff works ;)<br>
<br>
</div>I just had a new idea. All users who reported the mysterious all-zero<br>
LM96000 chip also have a PC8374L or compatible super-I/O chip. I am<br>
almost certain that what sensors-detect identifies as an LM96000 is<br>
actually the PC8374L super-I/O chip, as it is documented as exposing<br>
its hardware monitoring registers on the SMBus.<br>
<br>
Please provide a dump of the logical device 8 of your Super-I/O:<br>
<br>
isadump 0x2e 0x2f 8<br>
</blockquote><div><br><br># isadump 0x2e 0x2f 8<br>WARNING! Running this program can cause system crashes, data loss and worse!<br>I will probe address register 0x2e and data register 0x2f.<br>Probing bank 8 using bank register 0x07.<br>
Continue? [Y/n] y<br>&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5&nbsp; 6&nbsp; 7&nbsp; 8&nbsp; 9&nbsp; a&nbsp; b&nbsp; c&nbsp; d&nbsp; e&nbsp; f<br>00: 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00 00<br>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 41<br>20: f1 01 00 00 01 01 00 91 00 11 2e 00 00 10 00 00<br>
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>70: 00 03 00 00 04 04 00 00 00 00 00 00 00 00 00 00<br>
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br>f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00<br><br><br>So I was looking into this a little more and I came across an Intel driver called HECI.&nbsp; I guess it was submitted to the linux kernel, but hasn&#39;t made it in yet.&nbsp; At any rate, I downloaded it and some other goodies from <a href="http://www.openamt.org/">http://www.openamt.org/</a>.&nbsp; In short, I tweaked a few places to get it to compile and load for my kernel, 2.6.27 (actually on .28-rc3 now).&nbsp; But I think this is the new way to access all the Intel sensors, etc.&nbsp; I don&#39;t know much about it yet, looks like it can do alot.&nbsp; But I didn&#39;t see a way to get the temp assets from any of the examples, and I don&#39;t think I&#39;ll have anymore time to look into this further.&nbsp; <br>
<br>Thanks for all your help though, but I think you are right.&nbsp; Accessing the temps via the tradional drivers (for lack of better word) is never going to happen.&nbsp; I think its going to be through this HECI driver, but it looks like whatever support was being put into that has flat lined.<br>
<br>Thanks again<br></div></div>

------=_Part_51285_1246850.1226108281011--


--===============7350181028162310226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7350181028162310226==--

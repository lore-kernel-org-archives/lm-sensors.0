From: "Dean Loros" <autocrosser1@gmail.com>
Date: Wed, 10 Sep 2008 19:16:42 +0000
Subject: Re: [lm-sensors] Results of running your sensors-detect
Message-Id: <2f1459c40809101216t2d02b251r6099a1a969a7e7ea@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9194110576991058804=="
List-Id: <lm-sensors.vger.kernel.org>
References: <48C719D9.90000@gmail.com>
In-Reply-To: <48C719D9.90000@gmail.com>
To: lm-sensors@vger.kernel.org

--===============9194110576991058804==
Content-Type: multipart/alternative; 
	boundary="----=_Part_35555_19458622.1221074202523"

------=_Part_35555_19458622.1221074202523
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jean--

OK, I would like a update if you think of anything "interesting"--I'll just
keep an eye on the sensors list.......

Cheers!!
Dean

On Wed, Sep 10, 2008 at 8:53 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Dean,
>
> On Wed, 10 Sep 2008 07:02:45 -0700, Dean Loros wrote:
> > OK Jean---
> >
> > ran check---results.
> > (...)
> > Now follows a summary of the probes I have just done.
> > Just press ENTER to continue:
> >
> > Driver `w83627ehf' (should be inserted):
> >   Detects correctly:
> >   * ISA bus, address 0x290
> >     Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)
> >
> > Driver `coretemp' (should be inserted):
> >   Detects correctly:
> >   * Chip `Intel Core family thermal sensor' (confidence: 9)
>
> Good, no longer suggests the lm78. Thanks for testing.
> > dean@linux:~/Desktop$ modprobe i2c-dev
> > dean@linux:~/Desktop$ i2cdump 1 0x49
> > No size specified (using byte-data access)
> > Error: Could not open file `/dev/i2c-1': Permission denied
> > Run as root?
> > dean@linux:~/Desktop$ sudo i2cdump 1 0x49
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> > I will probe file /dev/i2c-1, address 0x49, mode byte
> > Continue? [Y/n] y
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > f0: ff ff ff ff ff ff ff ff 00 8d 00 00 ff ff ff ff    .........?......
>
> Hmm, I don't know what it is, but it doesn't look like a hardware
> monitoring chip for sure.
>
> > Left lm78 unloaded--what next?
>
> I am out of ideas, sorry.
>
> --
> Jean Delvare
>

------=_Part_35555_19458622.1221074202523
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Jean--<br><br>OK, I would like a update if you think of anything &quot;interesting&quot;--I&#39;ll just keep an eye on the sensors list.......<br><br>Cheers!!<br>Dean<br><br><div class="gmail_quote">On Wed, Sep 10, 2008 at 8:53 AM, Jean Delvare <span dir="ltr">&lt;<a href="mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Dean,<br>
<div class="Ih2E3d"><br>
On Wed, 10 Sep 2008 07:02:45 -0700, Dean Loros wrote:<br>
&gt; OK Jean---<br>
&gt;<br>
&gt; ran check---results.<br>
</div>&gt; (...)<br>
<div class="Ih2E3d">&gt; Now follows a summary of the probes I have just done.<br>
&gt; Just press ENTER to continue:<br>
&gt;<br>
&gt; Driver `w83627ehf&#39; (should be inserted):<br>
&gt; &nbsp; Detects correctly:<br>
&gt; &nbsp; * ISA bus, address 0x290<br>
&gt; &nbsp; &nbsp; Chip `Winbond W83627DHG Super IO Sensors&#39; (confidence: 9)<br>
&gt;<br>
&gt; Driver `coretemp&#39; (should be inserted):<br>
&gt; &nbsp; Detects correctly:<br>
&gt; &nbsp; * Chip `Intel Core family thermal sensor&#39; (confidence: 9)<br>
<br>
</div>Good, no longer suggests the lm78. Thanks for testing.<br>
<div><div></div><div class="Wj3C7c">&gt; dean@linux:~/Desktop$ modprobe i2c-dev<br>
&gt; dean@linux:~/Desktop$ i2cdump 1 0x49<br>
&gt; No size specified (using byte-data access)<br>
&gt; Error: Could not open file `/dev/i2c-1&#39;: Permission denied<br>
&gt; Run as root?<br>
&gt; dean@linux:~/Desktop$ sudo i2cdump 1 0x49<br>
&gt; No size specified (using byte-data access)<br>
&gt; WARNING! This program can confuse your I2C bus, cause data loss and worse!<br>
&gt; I will probe file /dev/i2c-1, address 0x49, mode byte<br>
&gt; Continue? [Y/n] y<br>
&gt; &nbsp; &nbsp; &nbsp;0 &nbsp;1 &nbsp;2 &nbsp;3 &nbsp;4 &nbsp;5 &nbsp;6 &nbsp;7 &nbsp;8 &nbsp;9 &nbsp;a &nbsp;b &nbsp;c &nbsp;d &nbsp;e &nbsp;f &nbsp; &nbsp;0123456789abcdef<br>
&gt; 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff &nbsp; &nbsp;................<br>
&gt; f0: ff ff ff ff ff ff ff ff 00 8d 00 00 ff ff ff ff &nbsp; &nbsp;.........?......<br>
<br>
</div></div>Hmm, I don&#39;t know what it is, but it doesn&#39;t look like a hardware<br>
monitoring chip for sure.<br>
<div class="Ih2E3d"><br>
&gt; Left lm78 unloaded--what next?<br>
<br>
</div>I am out of ideas, sorry.<br>
<br>
--<br>
<font color="#888888">Jean Delvare<br>
</font></blockquote></div><br></div>

------=_Part_35555_19458622.1221074202523--


--===============9194110576991058804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9194110576991058804==--

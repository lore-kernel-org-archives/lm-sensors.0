From: "Anthony Arobone" <aaroboneml@gmail.com>
Date: Thu, 18 Sep 2008 23:58:23 +0000
Subject: [lm-sensors] Intel DG45FC
Message-Id: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5890004104127745496=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5890004104127745496==
Content-Type: multipart/alternative; 
	boundary="----=_Part_40450_20215063.1221782303437"

------=_Part_40450_20215063.1221782303437
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I apologize if this was already brought up on the list.

I just purchased an Intel DG45FC mini-itx board (I believe this is
considered ICH10, or some variation).  I can't seem to get lm_sensors to
report the temps/fans/volts of the board.  Everything is zero.  The cpu
temps are working via the coretemp module, but nothing else.  Here is what
I'm doing:

Gentoo 2.6.26-r1 kernel; using i2c-i801 as module, lm85 as module.
SVN lm_sensors as of maybe a week ago, just the apps

When I run sensors-detect it tells me I should be using lm85.  I modprobe
lm85 successfully but when I run sensors everything is zero.

Is this the correct module for this board?  I can't seem to find any info
about the chip/sensor on board.
You probably want to see the output of lspci -v but I don't have the board
hooked up right now, will hookup this weekend.  What I can tell you is that
the device id is "3a30" from the lspci output.  And the chipset is the G45.

Any ideas?  Thanks

------=_Part_40450_20215063.1221782303437
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">I apologize if this was already brought up on the list.<br><br>I just purchased an Intel DG45FC mini-itx board (I believe this is considered ICH10, or some variation).&nbsp; I can&#39;t seem to get lm_sensors to report the temps/fans/volts of the board.&nbsp; Everything is zero.&nbsp; The cpu temps are working via the coretemp module, but nothing else.&nbsp; Here is what I&#39;m doing:<br>
<br>Gentoo 2.6.26-r1 kernel; using i2c-i801 as module, lm85 as module.<br>SVN lm_sensors as of maybe a week ago, just the apps<br><br>When I run sensors-detect it tells me I should be using lm85.&nbsp; I modprobe lm85 successfully but when I run sensors everything is zero.<br>
<br>Is this the correct module for this board?&nbsp; I can&#39;t seem to find any info about the chip/sensor on board.<br>You probably want to see the output of lspci -v but I don&#39;t have the board hooked up right now, will hookup this weekend.&nbsp; What I can tell you is that the device id is &quot;3a30&quot; from the lspci output.&nbsp; And the chipset is the G45.<br>
<br>Any ideas?&nbsp; Thanks<br></div>

------=_Part_40450_20215063.1221782303437--


--===============5890004104127745496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5890004104127745496==--

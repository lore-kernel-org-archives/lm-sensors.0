From: Rusty Waters <rusty0829@yahoo.com>
Date: Wed, 04 Nov 2009 23:13:17 +0000
Subject: [lm-sensors] lm_sensors problems with nVidia 9300-d-e and ION boards
Message-Id: <750957.3717.qm@web65504.mail.ac4.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8898448633375158148=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8898448633375158148==
Content-Type: multipart/alternative; boundary="0-312722156-1257376397=:3717"

--0-312722156-1257376397=:3717
Content-Type: text/plain; charset=us-ascii

Hi All,

We are trying to validate a few new boards, that all have nVidia chipsets on them. I am totally frustrated and would like to see if anybody else
can tell me how to go about getting sensors to work. The I2C chipsets on these boards are MCP79, which means they use i2c-nforce2 drivers.
These boards come from Zotac, and Pegatron in particular.
I have used Ubuntu Jaunty 9.04, Ubuntu 9.10 Karmic Koala, and also Fedora Core 11, none work out of the box.
In each of these version I then downloaded the lm-sensors 3.1.1, made it, installed it and followed it to the best of my current abilities.
Also used the newest version of sensors-detect.

The only sensors I get working are the 2 CPU temps, in all cases. Why cannot it sense the i2c MCP79, and get me fan speeds, for example?

If need be, I'd be glad to get your group a board to use.

I apologize if this is not the right mailing list, but if so, could you point me to the lm-sensors-users, or whatever it may be?

Thanks for your help,

 ~Rusty



      
--0-312722156-1257376397=:3717
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman,new york,times,serif;font-size:12pt">Hi All,<br><br>We are trying to validate a few new boards, that all have nVidia chipsets on them. I am totally frustrated and would like to see if anybody else<br>can tell me how to go about getting sensors to work. The I2C chipsets on these boards are MCP79, which means they use i2c-nforce2 drivers.<br>These boards come from Zotac, and Pegatron in particular.<br>I have used Ubuntu Jaunty 9.04, Ubuntu 9.10 Karmic Koala, and also Fedora Core 11, none work out of the box.<br>In each of these version I then downloaded the lm-sensors 3.1.1, made it, installed it and followed it to the best of my current abilities.<br>Also used the newest version of sensors-detect.<br><br>The only sensors I get working are the 2 CPU temps, in all cases. Why cannot it sense the i2c MCP79, and get me fan speeds, for
 example?<br><br>If need be, I'd be glad to get your group a board to use.<br><br>I apologize if this is not the right mailing list, but if so, could you point me to the lm-sensors-users, or whatever it may be?<br><br>Thanks for your help,<br><div>&nbsp;</div>~Rusty<div><br></div>
<!-- cg32.c2.mail.ac4.yahoo.com compressed/chunked Wed Nov  4 09:22:57 PST 2009 -->
</div><br>

      </body></html>
--0-312722156-1257376397=:3717--


--===============8898448633375158148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8898448633375158148==--

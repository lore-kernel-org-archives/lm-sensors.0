From: member graysky <graysky@archlinux.us>
Date: Tue, 02 Nov 2010 19:17:14 +0000
Subject: [lm-sensors] Motherboard Specific Configuration - Zotac IONITX-A-U
Message-Id: <AANLkTik-A2O0zuGijPCiDqQwh8m21ifeDAqcFGp_p53j@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7630456433975357396=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7630456433975357396==
Content-Type: multipart/alternative; boundary=0016367fb867b811bc049416c521

--0016367fb867b811bc049416c521
Content-Type: text/plain; charset=ISO-8859-1

I was directed by the wiki to post my config to the mailing list so a
registered user can create an entry for my motherboard.

/etc/sensors3.conf

# ZOTAC IONITX-A-U Atom 330 1.6GHz Dual-Core 441 NVIDIA ION
# needs both coretemp and lm90 modules

chip "coretemp-isa-0000"
label temp1 "Core0"
compute temp1 @+20,@-20

chip "coretemp-isa-0001"
label temp1 "Core1"
compute temp1 @+20,@-20

chip "w83l771-*"
label temp1 "M/B Temp"
label temp2 "CPU Temp"

--0016367fb867b811bc049416c521
Content-Type: text/html; charset=ISO-8859-1

I was directed by the wiki to post my config to the mailing list so a registered user can create an entry for my motherboard.<br><br>/etc/sensors3.conf<br><br># ZOTAC IONITX-A-U Atom 330 1.6GHz Dual-Core 441 NVIDIA ION<br>
# needs both coretemp and lm90 modules<br><br>chip &quot;coretemp-isa-0000&quot;<br>label temp1 &quot;Core0&quot;<br>compute temp1 @+20,@-20<br><br>chip &quot;coretemp-isa-0001&quot;<br>label temp1 &quot;Core1&quot;<br>compute temp1 @+20,@-20<br>
<br>chip &quot;w83l771-*&quot;<br>label temp1 &quot;M/B Temp&quot;<br>label temp2 &quot;CPU Temp&quot;<br><br><br>

--0016367fb867b811bc049416c521--


--===============7630456433975357396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7630456433975357396==--

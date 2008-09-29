From: "Pierre Bauduin" <pierre@baudu.in>
Date: Mon, 29 Sep 2008 19:00:10 +0000
Subject: [lm-sensors] on a "via686a-*" sensors reports always the same
Message-Id: <7cd7a3e80809291200n3cabe876u1fb8384d422bb168@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8517179503737685141=="
List-Id: <lm-sensors.vger.kernel.org>
References: <7cd7a3e80809290142w32aea211l3b35834000a1cbef@mail.gmail.com>
In-Reply-To: <7cd7a3e80809290142w32aea211l3b35834000a1cbef@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============8517179503737685141==
Content-Type: multipart/alternative; 
	boundary="----=_Part_61_15160536.1222714810564"

------=_Part_61_15160536.1222714810564
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi there,

More information regarding the previous message:

I forgot to tell you I had this error message when booting:
via686a 0000:00:07.4: base address not set - upgrade BIOS or use
force_addr=0xaddr
so I had to add the following line:
options via686a force_addr=0x6000
in the file /etc/modprobe.d/options

... I guess that's where I am wrong.

Perhaps isn't 0x6000 the right value ? I googled for "via686a base address
not set" and in most cases the value was 0x6000

Thank you,
-- 
Pierre Bauduin

------=_Part_61_15160536.1222714810564
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi there,<br><br>More information regarding the previous message:<br><br>I forgot to tell you I had this error message when booting:<br><span style="font-family: courier new,monospace;">via686a 0000:00:07.4: base address not set - upgrade BIOS or use force_addr=0xaddr</span><br>
so I had to add the following line:<br><span style="font-family: courier new,monospace;">options via686a force_addr=0x6000</span><br>in the file /etc/modprobe.d/options<br><br>
... I guess that&#39;s where I am wrong.<br><br>Perhaps isn&#39;t 0x6000 the right value ? I googled for &quot;via686a base address not set&quot; and in most cases the value was 0x6000<br><br>Thank you,<br>-- <br>Pierre Bauduin
</div>

------=_Part_61_15160536.1222714810564--


--===============8517179503737685141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8517179503737685141==--

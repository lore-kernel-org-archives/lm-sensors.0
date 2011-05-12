From: Steve.Glendinning@smsc.com
Date: Thu, 12 May 2011 08:26:29 +0000
Subject: Re: [lm-sensors] [PATCH] Document existing support for SMSC EMC2300
Message-Id: <OF63DC6DEC.2D155EFB-ONC125788E.002E5E7B-C125788E.002E5EC7@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
In-Reply-To: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--=_mixed 002E5EC6C125788E_MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<FONT face="Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=2><DIV>Hi Jean,<BR><DIV><BR>&gt;&gt;&gt;&nbsp;BTW,&nbsp;if&nbsp;you&nbsp;could&nbsp;provide&nbsp;a&nbsp;register&nbsp;dump&nbsp;for&nbsp;the&nbsp;EMC2300&nbsp;(using <BR>&gt;&gt;the&nbsp; <BR>&gt;&gt;&gt;&nbsp;i2c-dev&nbsp;kernel&nbsp;driver&nbsp;and&nbsp;i2cdump&nbsp;tool&nbsp;from&nbsp;the&nbsp;i2c-tools<BR>&gt;package) <BR>&gt;&gt;that&nbsp; <BR>&gt;&gt;&gt;&nbsp;would&nbsp;be&nbsp;appreciated.&nbsp; <BR></DIV><DIV>Dump as requested:</DIV><DIV>&nbsp;</DIV><DIV><A href="mailto:ste@mustafa:~$" target=blank>ste@mustafa:~$</A> sudo i2cdump 3 0x2e b<BR>WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>I will probe file /dev/i2c-3, address 0x2e, mode byte<BR>Continue? [Y/n] <BR>&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 1&nbsp; 2&nbsp; 3&nbsp; 4&nbsp; 5&nbsp; 6&nbsp; 7&nbsp; 8&nbsp; 9&nbsp; a&nbsp; b&nbsp; c&nbsp; d&nbsp; e&nbsp; f&nbsp;&nbsp;&nbsp; 0123456789abcdef<BR>00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>20: bf ff ff ff ff ff 00 ff dd 02 ff ff ff ff ff ff&nbsp;&nbsp;&nbsp; ?.......??......<BR>30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 6a&nbsp;&nbsp;&nbsp; ..............\j<BR>40: 04 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f&nbsp;&nbsp;&nbsp; ?.............??<BR>50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c3&nbsp;&nbsp;&nbsp; ????........bbb?<BR>60: c3 c3 e0 00 80 80 80 80 80 80 64 64 64 44 40 00&nbsp;&nbsp;&nbsp; ???.??????dddD@.<BR>70: ff ff ff 09 09 09 09 07 07 00 00 00 40 00 ec 10&nbsp;&nbsp;&nbsp; ...??????...@.??<BR>80: 1e a4 0e 00 00 ff ff ff ff 03 57 57 0b 0b 0b 00&nbsp;&nbsp;&nbsp; ???......?WW???.<BR>90: 04 04 04 04 0c 0c 0c 5a f1 00 00 00 23 00 00 00&nbsp;&nbsp;&nbsp; ???????Z?...#...<BR>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................<BR>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp; ................</DIV><DIV>&nbsp;</DIV><DIV>&nbsp;</DIV><DIV>Steve</DIV></DIV></FONT>
--=_mixed 002E5EC6C125788E_Content-Type: application/octet-stream; name="i2cdump.txt"
Content-Disposition: attachment; filename="i2cdump.txt"
Content-Transfer-Encoding: base64

c3RlQG11c3RhZmE6fiQgc3VkbyBpMmNkdW1wIDMgMHgyZSBiCldBUk5JTkchIFRoaXMgcHJvZ3Jh
bSBjYW4gY29uZnVzZSB5b3VyIEkyQyBidXMsIGNhdXNlIGRhdGEgbG9zcyBhbmQgd29yc2UhCkkg
d2lsbCBwcm9iZSBmaWxlIC9kZXYvaTJjLTMsIGFkZHJlc3MgMHgyZSwgbW9kZSBieXRlCkNvbnRp
bnVlPyBbWS9uXSAKICAgICAwICAxICAyICAzICA0ICA1ICA2ICA3ICA4ICA5ICBhICBiICBjICBk
ICBlICBmICAgIDAxMjM0NTY3ODlhYmNkZWYKMDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwICAgIC4uLi4uLi4uLi4uLi4uLi4KMTA6IDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAgIC4uLi4uLi4uLi4uLi4uLi4K
MjA6IGJmIGZmIGZmIGZmIGZmIGZmIDAwIGZmIGRkIDAyIGZmIGZmIGZmIGZmIGZmIGZmICAgID8u
Li4uLi4uPz8uLi4uLi4KMzA6IGZmIGZmIGZmIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDVjIDZhICAgIC4uLi4uLi4uLi4uLi4uXGoKNDA6IDA0IDAwIDAwIDAwIDAwIGZmIDAwIGZm
IDAwIGZmIDAwIGZmIDAwIGZmIDgxIDdmICAgID8uLi4uLi4uLi4uLi4uPz8KNTA6IDgxIDdmIDgx
IDdmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIDYyIDYyIDYyIGMzICAgID8/Pz8uLi4uLi4uLmJi
Yj8KNjA6IGMzIGMzIGUwIDAwIDgwIDgwIDgwIDgwIDgwIDgwIDY0IDY0IDY0IDQ0IDQwIDAwICAg
ID8/Py4/Pz8/Pz9kZGREQC4KNzA6IGZmIGZmIGZmIDA5IDA5IDA5IDA5IDA3IDA3IDAwIDAwIDAw
IDQwIDAwIGVjIDEwICAgIC4uLj8/Pz8/Py4uLkAuPz8KODA6IDFlIGE0IDBlIDAwIDAwIGZmIGZm
IGZmIGZmIDAzIDU3IDU3IDBiIDBiIDBiIDAwICAgID8/Py4uLi4uLj9XVz8/Py4KOTA6IDA0IDA0
IDA0IDA0IDBjIDBjIDBjIDVhIGYxIDAwIDAwIDAwIDIzIDAwIDAwIDAwICAgID8/Pz8/Pz9aPy4u
LiMuLi4KYTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
ICAgIC4uLi4uLi4uLi4uLi4uLi4KYjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwICAgIC4uLi4uLi4uLi4uLi4uLi4KYzA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAgIC4uLi4uLi4uLi4uLi4uLi4KZDA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAgIC4uLi4uLi4u
Li4uLi4uLi4KZTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwICAgIC4uLi4uLi4uLi4uLi4uLi4KZjA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwICAgIC4uLi4uLi4uLi4uLi4uLi4KCg=

--=_mixed 002E5EC6C125788E_Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=_mixed 002E5EC6C125788E_=--

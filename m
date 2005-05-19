From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: [Fwd: About IBM x323 and lm_sensors]
Message-Id: <3F4A8F21.6010509@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
From: 	- Mon Aug 25 15:34:27 2003
X-UIDL: 	0f0ff054686be1ff
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	00000000
Return-Path: 	<imre.oolberg@riik.ee>
Received: 	from umbleja.auul (213-35-150-38-dsl.trt.estpak.ee 
[213.35.150.38]) by Ren.netroedge.com (8.12.8p1/8.12.8) with ESMTP id 
h7PKk8IP003910 for <phil@netroedge.com>; Mon, 25 Aug 2003 13:46:09 -0700
Received: 	by umbleja.auul (Postfix, from userid 1000) id D5209DB813A; 
Mon, 25 Aug 2003 23:56:33 +0300 (EEST)
Received: 	from localhost (localhost [127.0.0.1]) by umbleja.auul 
(Postfix) with ESMTP id D2445564642 for <phil@netroedge.com>; Mon, 25 
Aug 2003 23:56:33 +0300 (EEST)
Date: 	Mon, 25 Aug 2003 23:56:33 +0300 (EEST)
From: 	Imre Oolberg <imre.oolberg@riik.ee>
X-X-Sender: 	imre@umbleja.auul
To: 	phil@netroedge.com
Subject: 	About IBM x323 and lm_sensors
Message-ID: 	<Pine.LNX.4.44.0308252340380.31421-100000@umbleja.auul>
MIME-Version: 	1.0
Content-Type: 	TEXT/PLAIN; charset=US-ASCII
X-Quarentine-Loop: 	Processed
X-Spambayes-Classification: 	unsure; 0.22



Hallo!

I started to manage serveral IBM xseries servers, some of them having
ServerWorks OSB4 chipset running Linux kernel 2.4.22, like this

SvrWks OSB4: IDE controller at PCI slot 00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later

I have been using some time ago lm_sensors and it worked for me nice on
common PIIX and VIA chipset motherbords.

Now, i just compiled the 2.4.22 kernel and also following closely
instructions the i2c and lm_sensors. I guess that my problem is not
so to say 'unresolved symbols' but something else. Loading i2c-piix4
module it says that i got IBM Laptop etc

i2c-piix4.o version 2.8.0 (20030714)
Found ServerWorks OSB4 South Bridge device
dmi_scan.o version 2.8.0 (20030714)
dmi_scan.o: SM BIOS found
i2c-piix4.o: IBM Laptop detected; this module may corrupt
             your serial eeprom! Refusing to load module!

I must say that i am aware of the problem with IBM Thinkpads and i
believed that this problem ise espessially related to chips they use in
laptops. Also i read that for safety reasons are hardcoded into lm_sensors
to stop when it detects IBM as a system manufacturer from BIOS.

Could you please tell me is there some reasonable way to start using
lm_sensors v. 2.8.0 on IBM x323 servers? I couldnt yet find out whether
these servers really contain the problematic Atmel 24RF08 eeprom.


Best Regards,

Imre Oolberg



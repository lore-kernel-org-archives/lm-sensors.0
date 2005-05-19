From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: [Fwd: A question about lm_sensors on IBM]
Message-Id: <3F6B4126.7070302@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
From: 	- Thu Sep 18 14:23:07 2003
X-UIDL: 	20ccb3ad5d3dd1d0
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	00000000
Return-Path: 	<ramsay@sedsystems.ca>
Received: 	from nelson.sedsystems.ca (nelson.SEDSystems.ca 
[192.107.131.136]) by Ren.netroedge.com (8.12.10/8.12.8) with ESMTP id 
h8ILDwJE024029 for <phil@netroedge.com>; Thu, 18 Sep 2003 14:13:58 -0700
Received: 	from barney.sedsystems.ca (IDENT:root@barney.SEDSystems.ca 
[198.169.180.121]) by nelson.sedsystems.ca with ESMTP id h8ILPeH05387 
for <phil@netroedge.com>; Thu, 18 Sep 2003 15:25:41 -0600 (CST)
Received: 	from sedsystems.ca (sw-63.SEDSystems.ca [192.107.131.180]) by 
barney.sedsystems.ca (8.9.3/8.9.3) with ESMTP id PAA22997 for 
<phil@netroedge.com>; Thu, 18 Sep 2003 15:44:33 -0600
Message-ID: 	<3F6A2294.5020507@sedsystems.ca>
Date: 	Thu, 18 Sep 2003 15:24:36 -0600
From: 	Jim Ramsay <ramsay@sedsystems.ca>
Organization: 	SED Sytsems, A Division of Calian Ltd.
User-Agent: 	Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) 
Gecko/20030901 Thunderbird/0.2
X-Accept-Language: 	en-us, en
MIME-Version: 	1.0
To: 	phil@netroedge.com
Subject: 	A question about lm_sensors on IBM
Content-Type: 	text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 	7bit
X-Quarentine-Loop: 	Processed
X-Spambayes-Classification: 	ham; 0.07



Hello, Philip.

I work for a company who has in the past used lm_sensors for monitoring 
temperature in various hardware running linux, and we've been really 
impressed with it.

The problem we've got now is that we are required to use some IBM 
servers, and of course lm_sensors won't run on them because of the 
Thinkpad 24RF08 EPROM issue.

The other problem we've got is that because of other software 
constraints, we cannot upgrade our Linux past an approximate RedHat 7.0 
(Kernel 2.2.16).  This means that 1) All of IBM's proprietary 
temperature monitoring stuff won't run, and 2) I am stuck using 
lm_sensors/i2c 2.7.0

As far as I can tell so far these servers need the 'piix4' module.

I need to know if I can disable the check for the vendorID throughout 
lm_sensors, and if so how involved a change this would be, or if someone 
else has already done this.  I will of course only do so if our IBM 
servers do not have the affected 24RF08 EPROM chip in them.

Thanks for any help or advice you can give me on how to do this.

-- 
Jim Ramsay
Programmer Analyst
SED Systems, A Division of Calian Ltd.
email: ramsay@sedsystems.ca
phone: 306.933.1665



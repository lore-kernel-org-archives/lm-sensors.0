From: akpm@osdl.org (Andrew Morton)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Fw: [Bug 4332] System very slow with >=2.6.11-rc3
Message-Id: <20050313152714.3b31fb32.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Guys, could you please review this bug report?  Seems that
we have a regression in there.

Thanks.

Begin forwarded message:

Date: Sun, 13 Mar 2005 15:11:21 -0800
From: bugme-daemon@osdl.org
To: akpm@digeo.com
Subject: [Bug 4332] System very slow with >=2.6.11-rc3


http://bugme.osdl.org/show_bug.cgi?idC32





------- Additional Comments From jasmin@atlantica.ch  2005-03-13 15:11 -------
I narrowed the problem down now: 
2.6.11-rc3 works 
2.6.11-rc3-bk1 does not 
and it's only there if I load the modules i2c-i801 + w83781d. 
I also noticed that if I load the modules, the CPU temperature is totally 
wrong. After the modules are loaded, unloading them does not help. 
 

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

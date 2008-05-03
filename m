From: Achim Gottinger <achim@ag-web.biz>
Date: Sat, 03 May 2008 23:24:19 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <481CF423.6090103@ag-web.biz>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I took a picture of the board and numbered the chips.
http://www.abload.de/image.php?img=img_6532l9j.jpg

Chip 1-2 are the two NIC chips. Chip three is interesting.
It was hard to read but i found that chip ICS9LPRS477BKL

I found that article later explaining that chip as an clock generator.
http://www.planet3dnow.de/vbulletin/showthread.php?t30028&garpg=6

Here are specs for a chip with an very similar number which is a clock 
generator chip.
http://www.idt.com/?genID=9LPRS478

Chip four is something like ICS 7714084. The five chips with number five 
have a lable like PI2PCIE.
Chip 8 is the via firewire controller, number nine is the sensor chip 
and ten seems to be an ST75185C like RS-232 driver and receiver chip 
rellated to the com port connector next to him.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

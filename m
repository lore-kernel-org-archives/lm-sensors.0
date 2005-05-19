From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Fans
Message-Id: <20021115232926.KFEK1423.pop017.verizon.net@[192.168.1.101]>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021115113947.11c4b1d3.khali@linux-fr.org>
In-Reply-To: <20021115113947.11c4b1d3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

** Reply to message from Jean Delvare <khali@linux-fr.org> on Fri, 15 Nov 2002 11:39:47 +0100


# > So why do two of my fans not show up if he says that they are plugged
# > to the mainboard.
# 
# That I can't say. Unless you have a way to reach the machine and enter
# the bios to note what it reports, there's nothing more I can say. I
# suspect that Asus used some customized sensors chipset (they do it quite
# often) that we don't fully support. Please be patient, maybe we'll get
# some additional info someday, who knows.

You mess around with fanx_div and fanx_min and sooner or later you wil get a beep alarm for the one that is not configured properly.  My case fan is on fan3, but I cannot get anything out of it but  0 rpm, or "beep" when I set the min too high.


Ed Harrison, broadcasting on
----/ /
---/ /     (_) __  __  _    _ _   __ 
--/ /__ /  //   \/  // /_/ /\ \/  /
-/___//_//_/\_//__,_/ /_/\_\


by SuSE(8.1), Kernel 2.4.19, X 4.2
or Windows98 (running in vmware 3.2)
PolarBarMailer 1.23 with IBMJDK 1.3.1-2

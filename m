From: haimat@lame.at (Matthias F. Brandstetter)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: lm_sensors: output for all sensors?
Message-Id: <200407081308.52220.haimat@lame.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406161539.50952.haimat@lame.at>
In-Reply-To: <200406161539.50952.haimat@lame.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

---------- quoting Rudolf Marek ----------
> modprobe i2c-isa

Hi Rudolf, after loading this module, I now can see voltage and temp. 
statistics, thanks for your support. But now I can see a somewhat strange 
entry:

SYS Temp:  +51.3 C  (high =   +83 C, hyst =   +82 C)
CPU Temp:  +39.8 C  (high =  +146 C, hyst =   -71 C)

Are these entries correct? Is it possible, that my CPU has such a low 
temp.?

Greetings, Matthias

PS: I have one entry with "ALARM". What must happen, that such an "ALARM" 
gets displayed?

-- 
Aw, Dad, you've done a lot of great things, but you're a very old man, and
old people are useless.

		-- Homer Simpson
		   Homer the Vigilante

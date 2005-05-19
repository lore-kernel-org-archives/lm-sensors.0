From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Any success reading sensors on IBM 326, HP DL145, Sunfire v20z
Message-Id: <Pine.LNX.4.58.0502141723200.11696@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have tried to use lm_sensors to read out IBM e-server 326, HP DL145,
Sun Sunfire v20z.  On the IBM and sun all I can get are the eeprom's,
on the Sun sunfire I can get one w83627hf but with nothing
important attached to it.  Has anyone else done better up till now?
(note, the above are all opterons, I am running the 32-bit (athlon)
kernel on them at the moment and compiled i2c/lm_sensors 2.9.0 
accordingly).  Same RPMS work on Accelertech (HDAMA) and Tyan S2882.

Steve Timm


------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team

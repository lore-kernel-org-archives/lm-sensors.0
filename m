From: pierre-olivier.gaillard@fr.thalesgroup.com (P.O. Gaillard)
Date: Thu, 18 Aug 2005 11:39:33 +0000
Subject: [lm-sensors] A few remarks about the w83792d
Message-Id: <43045711.6040804@fr.thalesgroup.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

we are starting to use the driver on our machines and we noticed to things that 
we feel should be changed :
  - the values in /etc/sensors.conf for the CPU temperature threshold are very 
low (max:42? hyst:37?). This supersed the values set in the BIOS and is very 
low, causing the PC to beep everytime the CPU is loaded at 100%
  - when we read the sensors with sensors, we see the following message on the 
console :
  w83792d 0-002f: Starting device update.
  What kind of update is that ? Why do we cause one when we read the 
temperatures and fan states with sensors ? Why is there a console message for that ?

  thank you for your help and your work on lmsensors !

	P.O. Gaillard


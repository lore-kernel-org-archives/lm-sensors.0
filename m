From: vvenkataramana@yahoo.com (V. R. Venkatramana)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Question on CPU temperature and voltage devices (ADM1025)
Message-Id: <20020426182810.28830.qmail@web13408.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Folks, 

    How to access CPU temperature & voltage drvices?
    Sensor chip:   Analog Devices ADM1025 
    MotherBoard:   Intel D845WN

I am using vxWorks OS.  vxWorks do not support Advanced 
Configuration and Power Interface (ACPI) and cannot access 
temperature and voltage devices via ACPI calls in the BIOS.   
vxWorks do not have support to access SMBus either.

I am wondering how to access temperature an voltage devices
located on the SMBus in the absesnce of no suppport for i2c
and SMBus in vxWorks?  I have no problem in accessing fan 
devices (chassis fan & cpu fan) but cannot access sensor devices.

I am hoping that lm_sensor expert will answer my question and 
provide me pointers as to how to access sensor devices?

A line in reply will be appreciated.
Thanks, Venkat



__________________________________________________
Do You Yahoo!?
Yahoo! Games - play chess, backgammon, pool and more
http://games.yahoo.com/

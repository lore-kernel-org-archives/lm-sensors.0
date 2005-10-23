From: mds@mds.gotdns.com (Mark Studebaker)
Date: Sun, 23 Oct 2005 20:37:50 +0000
Subject: [lm-sensors] 87431 update
Message-Id: <435BD852.9040703@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Great news,
I've successfully implemented bmcsensors-over-IPMI-over-SMB, working
on the Intel Server donated by Aweta.

HW:
	Intel Server Platform SR1325TP1-E w/ 6300ESB SMBus and PC87431 at 0x42

SW:
	kernel-2.6.12-1.1380_FC3.src.rpm
	linux-ipmi-2.6.12-base.diff
	linux-ipmi-2.6.12-smb.diff
	linux-i2c-2.6.12-nonblock.diff
	linux-i2c-2.6.12-i801-nonblock.diff
	bmcsensors-26-20050808.tar.bz2

sensors output:

bmc-i2c-2-00
Adapter: IPMI adapter
Baseboard 1.5V:
           +1.52 V  (min =  +1.35 V, max =  +1.65 V)   
Baseboard 3.3V:
           +3.34 V  (min =  +2.99 V, max =  +3.62 V)   
Baseboard 5.0V:
           +5.05 V  (min =  +4.54 V, max =  +5.48 V)   
Baseboard 12V:
          +11.80 V  (min =  +9.97 V, max = +13.28 V)   
MCH Vtt:   +1.17 V  (min =  +1.25 V, max =  +1.60 V)   
Processor Vccp:
           +1.36 V  (min =  +1.15 V, max =  +1.71 V)   
Baseboard Fan 1:
          15408 RPM  (min = 7369 RPM)                  
Baseboard Fan 2:
          15408 RPM  (min = 7369 RPM)                  
Baseboard Fan 3:
          13037 RPM  (min = 7369 RPM)                  
Baseboard Fan 5:
          14124 RPM  (min = 7369 RPM)                  
Baseboard Fan 6:
          15408 RPM  (min = 7369 RPM)                  
Baseboard Temp:
           +37.0??C  (high =   +54??C, hyst =    +2??C)   
Processor1 Temp:
           +51.0??C  (high =   +80??C, hyst =    +2??C)   

IPMI-i2c-0-42
Adapter: SMBus I801 adapter at 0400




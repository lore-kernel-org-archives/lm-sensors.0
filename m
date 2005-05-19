From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] Sensors chip w83781d for linux-2.5.6[45] (follow up on PCI
Message-Id: <20030322131503.254c2aa7.azarah@gentoo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030322034553.1c18f077.azarah@gentoo.org>
In-Reply-To: <20030322034553.1c18f077.azarah@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

After I had this P4T533-C's SMBus enabled again on 2.5 kernel with
Dominik's patch, I thought it will be a good time to try and get
lm_sensors to work again.

I did not have much luck with a CVS snapshot of lm_sensors2 though,
so I hacked 2.5.64bk12 to include the w83781d module.  Yes, it is
rather hackish, but it seems to work just fine.

This is with the standard i2c that comes with 2.5.64bk12:

----------------------------------------------------
i2c-i801.o version 2.7.0 (20021208)
i2c-dev.o: Registered 'SMBus I801 adapter at e800' as minor 0
w83781d.o version 2.7.0 (20021208)
----------------------------------------------------

----------------------------------------------------
# sensors
w83782d-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.45 V  (min =  +1.21 V, max =  +1.48 V)              (beep)
VCore 2:   +1.74 V  (min =  +1.21 V, max =  +1.48 V)              (beep)
+3.3V:     +3.28 V  (min =  +2.97 V, max =  +3.63 V)              (beep)
+5V:       +5.11 V  (min =  +4.50 V, max =  +5.48 V)              (beep)
+12V:     +11.86 V  (min = +10.79 V, max = +13.11 V)              
-12V:     -12.03 V  (min = -13.21 V, max = -10.90 V)              
-5V:       -5.10 V  (min =  -5.51 V, max =  -4.51 V)              
V5SB:      +0.13 V  (min =  +0.13 V, max =  +0.13 V)              
VBat:      +0.08 V  (min =  +0.08 V, max =  +0.08 V)              
CPU Fan:  4440 RPM  (min = 3000 RPM, div = 2)                     (beep)
M/B Temp:    +28?C  (limit =  +60?C) sensor = thermistor          (beep)
CPU Temp:  +46.0?C  (limit = +60?C, hysteresis =  +50?C) sensor thermistor           (beep)
VC Spec: +1.350 V
----------------------------------------------------

It should apply cleanly against 2.5.65, but on 56k, so will be a while
before its finished downloading.

Comments welcome.


Regards,

-- 

Martin Schlemmer


-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-chip-w83781d.patch
Type: application/octet-stream
Size: 79082 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030322/af3457d8/i2c-chip-w83781d.obj

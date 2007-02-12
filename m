From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Mon, 12 Feb 2007 17:53:24 +0000
Subject: [lm-sensors] VIA Epia EN12000 (w83697hf)
Message-Id: <45D0A994.5010604@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A5BA.4000902@xs4all.nl>
In-Reply-To: <45D0A5BA.4000902@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Udo van den Heuvel wrote:
> Anybody here using a VIA Epia EN12000?
> I am looking for confirmation that the conversion in sensors.conf for
> w83697hf on VIA EN12000 is accurate.

I am seeing stuff like:

# sensors
w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +0.82 V  (min =  +0.85 V, max =  +0.94 V)       ALARM
+3.3V:     +3.23 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.92 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.04 V  (min = +10.82 V, max = +13.19 V)
-12V:     -14.91 V  (min = -13.18 V, max = -10.80 V)       ALARM
-5V:       -7.71 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
V5SB:      +5.35 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
VBat:      +3.22 V  (min =  +2.40 V, max =  +3.60 V)
temp1:       +51??C  (high =   +67??C, hyst =   +65??C)   sensor transistor
temp2:     +30.5??C  (high =   +52??C, hyst =   +47??C)   sensor = diode
alarms:
beep_enable:
          Sound alarm enabled

CPU-voltage is 1.004v according to VIA's EN operating Guid v1.10. I
measure much less as you can see. Also CPU is kinda warm.
Sensor type of EN12000 is (transistpr/diode) is different from EK8000
(diode/transistor). Is this OK?


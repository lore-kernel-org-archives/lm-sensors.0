From: ml@secondimpact.de (Stephen D. Leedle)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: KSysGuard and lm_sensors
Message-Id: <200309211402.58124.ml@secondimpact.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everybody!

(Want to subscribe to this list)

My problem, in short terms:
I can't get KDE's KSysGuard to use lm_sensors as data source. I know(!) 
that there is this /opt/kde/etc/ksysguarddrc config file, which works 
with every other sensor, but only not with LmSensors.

System:
Slackware 9,
Kernel 2.4.22
KDE 3.1.3 (I know, there is 3.1.4, but the newest instable devel release 
3.1.91 (-> 3.2) is not solving this problem!)
i2c 2.8.0
lm_sensors 2.8.0

"# sensors" gives output, yes.

My question: Is this version of KSysGuard and lm_sensors incompatible to 
each other? I couldn't install an older version (2.7.0) because the 
"make" on lm_sensors-2.7.0 refused because of "an to old version of i2c 
(>= 2.7.0) which I have compiled and installed before.

OK, I might have done a fatal mistake at some place ... I'm not this 
experienced in Linux etc.

That's all I've got on my mind, for now, I would be happy about any 
suggestions, thanks for replies!

Greetings, Stephen

-- 
--
Stephen D. Leedle AKA Verlorene Seele AKA St. Douglas Lee De L'Est
ml@secondimpact.de

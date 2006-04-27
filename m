From: millerlf@telus.net (lloyd)
Date: Thu, 27 Apr 2006 14:25:10 +0000
Subject: [lm-sensors] user prog "sensors" seg faults on x86_64?
Message-Id: <4450D446.10303@telus.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We have a dual Opteron 285 system on a Tyan Tiger K8WE (S2877) 
motherboard. The make user ; make user_install went fine. The 
sensor-detect script seemed to run ok and the modprobes seemed to work 
but the "sensors -s" command segfaults. Is it a 64 bit problem? Using 
Suse 10.1 x86_64 beta atm.



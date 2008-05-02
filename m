From: Achim Gottinger <achim@ag-web.biz>
Date: Fri, 02 May 2008 21:18:18 +0000
Subject: [lm-sensors] sensors-detect killed my CPU
Message-Id: <481B851A.10800@ag-web.biz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi lm-sensors developers.

I just ran sensors-detect on my phenom system (9850BE, Sapphire AM2RD790 
Board, 2x1GB Crucial Ballistix DDR2-6400). It froze during SMbus scan 
and now the cpu seems to be defect.
The board stucks at C1 state during post, means it's a probem with the 
memory substytem.
I tried the cpu in another board (M3A) and no post here also. The system 
works fine with an 9600BE so it's definately the cpu, whom died during 
the sensors-detect run.

Greets
achim~


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

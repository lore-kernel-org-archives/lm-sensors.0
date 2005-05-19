From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <002701c4985c$2a95f3a0$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Actually, the data "appears" to be read correctly but temp2 is not
correct.  Also an ALARM where there should be none (in3).  A result of
forcing?

<SHELL>

<defiant> [2004-09-11@20:00:17] /etc -> sensors -s
<defiant> [2004-09-11@20:01:45] /etc -> sensors
w83781d-isa-0290
Adapter: ISA adapter
in0:       +2.00 V  (min =  +1.94 V, max =  +2.14 V)
in1:       +2.00 V  (min =  +1.94 V, max =  +2.14 V)
in2:       +3.57 V  (min =  +2.96 V, max =  +3.63 V)
in3:       +4.87 V  (min =  +4.73 V, max =  +5.24 V)       ALARM
in4:      +12.16 V  (min = +11.37 V, max = +12.59 V)
in5:      -11.96 V  (min = -12.57 V, max = -11.35 V)
in6:       -4.86 V  (min =  -5.25 V, max =  -4.74 V)
fan2:     3688 RPM  (min = 3245 RPM, div = 2)
temp1:       +29 C  (high =   +35 C, hyst =   +30 C)
temp2:    -128.0 C  (high =    +0 C, hyst =    +0 C)
vid:      +2.050 V
alarms:
beep_enable:
          Sound alarm disabled

</SHELL>



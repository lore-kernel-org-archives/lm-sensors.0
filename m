From: CyTech@telenet.be (stein)
Date: Wed, 02 Nov 2005 12:38:05 +0000
Subject: [lm-sensors] as99127f rev2.0
Message-Id: <1130931549.9178.9.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi all, i'm currently working on a asus cuv4x-dls motherboard with a
as99127f chip on the i?c bus..

currently i can snoop my i?c bus thruogh another pc, and have an asus
i-panel.. 

i'm able to control the fan speend trough the 0x59 register with values
like 0x8?h
where 0x8F is full speed, 
      0x8E is slightly lower
       ...    ...
0x8A is what the asus control panel (software) uses for low speed.. 
altough 0x89 also works (more slow..)




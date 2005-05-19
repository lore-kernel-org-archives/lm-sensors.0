From: mreedsmith@gmail.com (Matt Smith)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: IT87 on Shuttle SN41G2, similar: -5V, -12V
Message-Id: <41D20C82.50302@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Come across a lot of questions and no answers for this, so I thought I'd throw 
it your way

Shuttle uses some different resistors on their boards. I think it's a 1k and a 
4.1k on the -12V and a 1k and a 2.8k on the -5V, with the same 4.096V reference. 
I'd try to verify these values but all of the resistors are right below the 
power supply and behind the floppy connector so I can't really see them without 
taking the thing apart.

     compute in5 (5.1 * @) - 16.79  ,  (@ + 16.79) / 5.1
     compute in6 (3.8 * @) - 11.47  ,  (@ + 11.47) / 3.8

result:
-12V:     -11.89 V  (min = -12.63 V, max = -11.40 V)
-5V:       -5.03 V  (min =  -5.27 V, max =  -4.72 V)

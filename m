From: sukhdeep@gmail.com (Sukhdeep Johar)
Date: Tue, 21 Jun 2005 09:27:09 +0000
Subject: [lm-sensors] temp1,temp2 calculation in w83781d.c
Message-Id: <2ef564dc05062100266adaab51@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I see the temp1 being read as : 
          val*10           ; where val is the value read from the register. 

While temp2 is read as : 
         (val/128) *5.  ; where val is a two byte value read from the
registers.
I understand the reason behind the division by 128. 

But am not able to understand the multiplication by 5 & 10.
Can somebody please help me with this. Or point me to the relevant
material.

regards,
Sukhdeep

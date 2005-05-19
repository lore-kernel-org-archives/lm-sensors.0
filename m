From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: LM-Sensors TODO list: adm9240
Message-Id: <f2n571h8p0fbmkkd5c0sjevh7uo4en1fcb@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

There is a note in CVS TODO file about checking voltage reporting 
of adm9240, this I have done as far as revision 2 of the chip.  

The method I used to discover negative voltage resistor values 
also would account for the ~140k input impedance.  It is also 
a measurement dependent on reading two input voltages -- I wonder 
if whomever raised the TODO item remembers what their issue was?

--Grant.

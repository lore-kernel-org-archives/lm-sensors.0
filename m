From: galak@kernel.crashing.org (Kumar Gala)
Date: Fri, 17 Mar 2006 18:54:54 +0000
Subject: [lm-sensors] I2C-virtual and locking?
Message-Id: <6CCFFBB4-CDE0-4DC0-A4D7-A3E7398B2494@kernel.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm looking at porting the i2c-virtual code from 2.4 to 2.6.  One  
thing I'm not clear on is the use of i2c_add_adapter_nolock() by the  
old code.  The only reference I can find related to this is:

http://archives.andrew.net.au/lm-sensors/msg31060.html

I can't think of a reason why locking would be in issue when adding  
or removing of a virtual adapter.  Anyone have an additional ides on  
this?

- kumar


From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: RFC: planning on fixing w83697hf driver
Message-Id: <h00b61pqrl7b5mghaf65gvc8iq1r295dvg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Since I have a w83697hf to test, I'm about to repair the driver, 
anybody currently working on it?

Areas of interest: proper fan control, particularly in response 
to CPU temperature.  Previous driver testing was not on a system 
that monitored CPU temperature.

Automatic fan clock divider as this is yet another driver that 
wrongly reports zero rpm for a spinning fan :(

Cheers,
Grant.

From: rfn@buzzsaw.net (Rick F Nicholson)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Ticket 714
Message-Id: <200111092300.RAA09664@buzzsaw.buzzsaw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
In-Reply-To: <200111091109.FAA08820@buzzsaw.buzzsaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I added the "LM75" to the mix just because it had been detected. I normally loaded
just "i2c-viapro" and "w83781d". 

I think your comment about something else on the i2c bus being ill-behaved is
relevent. The onboard network drops out consistantly  when a "Bus Collision"
occurs.

Also tried just the "i2c-isa" and got the same results.

rfn

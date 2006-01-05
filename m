From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 05 Jan 2006 14:30:12 +0000
Subject: [lm-sensors] abit-uguru review  (OT diversion)
Message-Id: <43BD2D74.1030208@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:

sorry - I should have changed the subject-line earlier.

>
> I've thought about merging these too, but there actually a number of 
> subtile differences which when all added together make it easier to 
> just keep 2 versions:


reminds me of a pointless stupidity in pc87360 gpio.

the gpio unit has 29 gpios in 4 8 bit ports, 
2 of them have extra functionality.
sofar so good.

but their address map gives 4 addys per port for ports 1, 2,
and only 2 for ports 3,4

this complicates (ok, just a little) low-level routines needlessly,
and still requires higher levels to look at the index.

Needless obfuscation, and impediment to transparent functionality 
upgrades. IMHO.


/me says, thinking of my past errors, and their legacy ;-)


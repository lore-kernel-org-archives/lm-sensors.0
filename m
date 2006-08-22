From: anthony.calabro@lmco.com (Calabro, Anthony)
Date: Tue, 22 Aug 2006 20:19:55 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <ECFA7CB48E408A45987215BF5593E04708A1724F@emss09m08.us.lmco.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I guess Im going to try to start over with this thread.  I have solved
the Flex Scanner Jammed problem by going back to sensors version 2.9.0.
When using 2.10.0 the best I could do is get label lines to parse
correctly, but I never had any luck with the compute lines.  I also
upgraded my linux kernel from 2.6.9-34 to 2.6.9-42.  In this new version
there is an i2c sensors update.  We are running the newest version of
RedHat Enterprise with AS 4.  Is there any support for the Winbond
83627HG chip, or the nVidia nForce Pro 2200 (CK804)???  

Right now I have sensors up and running using the Winbond 83627HF
driver, and this is giving me incorrect readings.


Are these chips or busses supported right now?  


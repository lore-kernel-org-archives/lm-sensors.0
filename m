From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 26 Dec 2006 23:14:29 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <4dfa50520612261514v58791029xb96e18d01066ba91@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hamlet,

It looks like your temp3 is wrong and your voltages need a little
tweaking. To fix the voltages, you will need to edit your
sensors.conf. That part is not too hard.

temp1 is 'SYSTIN,' temp2 is 'CPUTIN,' and temp3 is 'AUXTIN.'  I think
your system temp and CPU temp look right. Does your AUXTIN value
change at all? It may be floating or pulled high -- both are
motherboard design decisions which mean that the temperature input is
useless. You can add a line to sensors.conf to ignore the temperature.

Hope that helps,
David


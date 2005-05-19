From: mdb36@cam.ac.uk (Michael Bell)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: Ticket number 1077, solved.
Message-Id: <3DF8BAB6.5060303@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I should have done that myself, sorry - the problem was that an old version 
of libsensors was in /usr/lib so the new version in /usr/local/lib was not 
being seen.

All working again now.  Thanks,

Michael.

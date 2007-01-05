From: hans.edgington@xs4all.nl (Hans Edgington)
Date: Fri, 05 Jan 2007 21:33:05 +0000
Subject: [lm-sensors] Problem with MSI K9N6SGM-V motherboard sensors
Message-Id: <000b01c73111$169e59f0$1f140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <459CA045.7050603@verizon.net>
In-Reply-To: <459CA045.7050603@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim & David,

The fintek f71882fg or EPoX EP1308 has the same chip-id, but can't find
anything about it on the net. From the pictures I can find, it could be the
chip in the top right corner of the mobo. Lm-sensors 2.10.1 won't detect it
you would need the on in the svn.

You could also check by running
isadump -k 0x87,0x87 0x4e 0x4f
And post the results.

If it is the f71882fg then the driver is being developed and is almost
finished. I will post it here as soon as it is.

Regards,
Hans



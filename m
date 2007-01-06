From: hans.edgington@xs4all.nl (Hans Edgington)
Date: Sat, 06 Jan 2007 11:25:44 +0000
Subject: [lm-sensors] Problem with MSI K9N6SGM-V motherboard sensors
Message-Id: <000301c73185$6b44c970$1f140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <459CA045.7050603@verizon.net>
In-Reply-To: <459CA045.7050603@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

Just I suspected this is the f71882fg

20: 05 41 20 19 34 00 80 5e 40 00 00 00 08 0e 00 00
    ^^ ^^    ^^ ^^
0541 is the chip id as you already said, and 1934 is the fintek ID. Support
for this chipset is being worked on and almost finished. Until it is
finished I'm afraid there isn't much you can do.

Results looked fine here.

regards



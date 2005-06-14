From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 14 Jun 2005 17:08:56 +0000
Subject: [lm-sensors] My 333 DIMMs are only being recognised as 266 by
Message-Id: <42AEF2B9.2000304@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <d8jidr$7rp$1@saturn.local.net>
In-Reply-To: <d8jidr$7rp$1@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Per,

You can try decode yourself.
As root you can do:
modprobe i2c-dev
i2cdump 0 0x50
(0 is bus number, 0x50 is first dimm slot, adjust as needed, you can use sensors command to tell you bus and chip number)
This will obtain memory dump to which you can apply DDR SPD specification
http://www.jedec.org/download/search/4_01_02_10R13.pdf
(or simply you can find it via google SPD DDR site:jedec.org)

Then you can try to decode the fields yourself. Just beware some parts of SPD specs have decimal instead of hex numbers.
I hope it helps

Regards

Rudolf

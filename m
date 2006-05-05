From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 05 May 2006 21:33:55 +0000
Subject: [lm-sensors] latest findings - my older posting from ~ 11 days
Message-Id: <445BC4C3.4030501@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200605022128.10627.dieter.jurzitza@t-online.de>
In-Reply-To: <200605022128.10627.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the report.

80c0: 68 48 20 2c 2c 6c 6c 6c 65 65 44 65 28 4c 20 44

the 0x48 means that DATA line of smbus is forced low
so the bus is stuck. The bit 5 offers the realtime status
of the bus line.

(http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/23167.pdf
page 83)

When the bus is stuck again you may try following:

rmmod i2c-amd756

Now lets reprogram the chipset to force 1 to the DATA line,
if the isadump will be 0x68 then the chipset has some bug
otherwise some device on the bus has the bug.

isaset -y -f 0x80c0 0x5
isaset -y -f 0x80c1 0x5
isadump -y -f 0x8000

Regards
Rudolf

Thanks,

regards
Rudolf


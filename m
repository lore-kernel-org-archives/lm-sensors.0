From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 26 Sep 2006 22:26:35 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <4519A91B.4020206@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,


Sorry for one more email. I should really go sleep...
It should work on Core Duo/Solo without "2" too.

cat /proc/cpuinfo should show:
cpu family      : 6
model           : 14

or:

cpu family      : 6
model           : 15

It does not support CPU hotplug yet...

Rudolf


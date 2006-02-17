From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 17 Feb 2006 21:49:06 +0000
Subject: [lm-sensors] CPU amd MB temperature never change on Asus A7N8X
Message-Id: <43F644D2.1030705@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F1EFBB.5060607@web.de>
In-Reply-To: <43F1EFBB.5060607@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
> Any Ideas what is going wrong here?

Yes you might have other chip for CPU temp. sensors-detect should find it too
(http://mbm.livewiredev.com/comp/asus.html says it is the W83L785TS)

Please provide the output of sensors-detect if the chip is not found.

Regards
Rudolf


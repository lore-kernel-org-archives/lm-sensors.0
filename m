From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 19 Sep 2006 07:11:07 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor	problems
Message-Id: <450F980B.6070908@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 
> Doesn't work for me :\ I still only get 4 fans.
> Maybe you could add some debugging output?

Please provide dumps of:
isadump 0x295 0x296
isadump -k 0x87,0x87 0x2e 0x2f

Thanks,

Rudolf


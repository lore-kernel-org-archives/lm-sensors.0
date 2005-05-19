From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: ATXP3 and ATXP5
Message-Id: <4277705D.9010400@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4277310B.9060700@sh.cvut.cz>
In-Reply-To: <4277310B.9060700@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> 
> I have ATXP3 :)
No I have ATXP2 even. I cant regulate voltage (athough I can set VID register and load atxp1 module), but this chip can regulate FSB

Near this chip is DIP switch to adjust FSB manually.
It has 24 legs total.

DIP SW combinations:

133 166 [OFF] [OFF]  [ON]  [ON]
100 133  [ON]  [ON]  [ON] [OFF]
133 100 [OFF]  [ON]  [ON] [OFF]
133 133 [OFF]  [ON] [OFF] [OFF]
100 100 [OFF] [OFF] [OFF] [OFF

So I think ATXP2 can adjust FSB and MEM frq somehow.

Regards

Rudolf

From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: i2c-sis645
Message-Id: <Pine.LNX.4.58.0405311809000.1458@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0405311653260.1458@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0405311653260.1458@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I would like know why on http://secure.netroedge.com/~lm78/supported.html
in row called

Sis 648/96x, 651/96x, 745/96x, 746/96x, xxx/962, xxx/963

Is no support for 2.6 and there is also not mentioned i2c-sis92x ?

I looked to a source of kernel, and it seems it to accept any SiS smbus
device with id 16.

My SiS745 chipset has 00:02.1 Class 0c05: 1039:0016. So I guess it should
work too.

Maybe mmh will know ?

Regards

Rudolf




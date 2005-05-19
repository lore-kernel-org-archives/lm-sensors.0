From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: [PATCH 2.6] Handle read errors in w83l785ts
Message-Id: <1075803415.401f751798623@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040202225211.40740d70.khali@linux-fr.org>
In-Reply-To: <20040202225211.40740d70.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James,

Your great perl script gave me an idea. Maybe it would be interesting
to alter the delays between reads when errors occur. For now I used a
short incremental delay (i, where i is the retry count). Other choices
are possible though:
* no delay at all (remove i2c_delay())
* incremental, bigger delay (say i2c_delay(4*i))
* constant delay (say i2c_delay(5))

If you have some spare time and can do some additional experiments with
some of these settings, it would be great. My goals are to lower the
probablity of 2 or more retries needed, and, if possible, to also lower
the probability of a first retry being needed.

My only fear is that the randomness could be too high for us to
conclude.

Anyway, my request is mostly the expression of the scientific mind
sleeping in me. The driver seems to work pretty well the way it is now,
so you are invited to decline unless you are looking for new ways to
waste your time or are yourself interested by the experiment.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

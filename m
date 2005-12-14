From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Dec 2005 19:03:36 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <20051214200336.0cae9908.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> And about algo PCA & PCF ?
> Do I need them ?

No, you don't. Algorithms are internal bus driver implementation
details, which non-developers don't have to care about. Ultimately, I'd
like to remove any reference to them in user-space, as this tends to
confuse users a lot. Anyone interesting in taking that particular job,
just speak up. It's probably quite easy.

-- 
Jean Delvare


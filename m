From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <20040922072707.M11840@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Sep 2004 16:14:20 -0700, David Mathog wrote
> VRM 1,2 read 61 and 56 degrees C, but when I put my finger on those
> regulators they only feel warm, not even uncomfortably so,
> those values must be bogus too.  There are some Tyan S2466 machines
> in my area and they only read about 40 degrees on the VRM with
> an AMD MP 2200+ in it, one would expect that AMD MP 2000+ should
> draw even less current.

Depends if the 2000+ are Palomino or Thoroughbred. In the former case, the
2000+ has a higher voltage (1.75V instead of 1.6-1.65V) and higher max
current, resulting in a higher max power consumption (+15% or so). I don't
have no figures for the average consumption, but I'd expect it to compare
similarly.

-- 
Jean Delvare
http://khali.linux-fr.org/

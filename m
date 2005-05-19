From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: W83L785 for 2.6 is written
Message-Id: <20040912211128.7c43f8f7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409032110560.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409032110560.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ruik,

> To other people:
> For what is VALUE(X) in static sensors_chip_feature ?

The item number in the procfs file, starting at 1. For example, for
positive voltages, VALUE(1) (first number in inN file) is typically low
limit, VALUE(2) (second number in inN file) is the high limit and
VALUE(3) (third number in the inN file) is the actual reading.

This obviously only applies to the 2.4 drivers since in 2.6 each feature
has its own file.

> And second question. I didnt find anything in chips.c lib to support
> temp sensor type? Did I missed something ?

Search for "sensor1" in w83781d_features[].

The new naming scheme for 2.6 is tempN_type.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

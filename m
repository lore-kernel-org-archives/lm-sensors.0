From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: national sensorpath bus
Message-Id: <20040810202301.37505247.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41181309.8020806@verizon.net>
In-Reply-To: <41181309.8020806@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> fyi
> a new serial bus from national, together with
> two bus master chipos (one a super I/O), and several temp. sensors.
> 
> Don't know how soon we may see these but it would be good to start
> thinking about the best way to support.
> 
> 
> http://www.national.com/appinfo/advancedio/sensorpath.html

Thanks the pointer, interesting to see a new technology meant to
workaround a problem I didn't even know existed (long analog paths
etc...)

I simply wonder if this will affect us at all. Maybe the Super-I/O chips
will hide the new protocols, e.g. by providing an ISA interface to the
sensorpath bus? I would simply wait and see these new chips in action,
and see if there's anything we should do then.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

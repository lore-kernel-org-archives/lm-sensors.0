From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Ticket #1851 - PATCH (take 2) for adm1026.c, kernel 2.6.10-bk6
Message-Id: <20050103221014.381efab7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D075.4000200@paradyne.com>
	<20050101001205.6b2a44d3.khali@linux-fr.org>
	<20050103194355.GA11979@penguincomputing.com>
	<20050103201056.3c55e330.khali@linux-fr.org>
	<20050103213707.GA12765@penguincomputing.com>
	<20050103205231.GK9923@schnapps.adilger.int>
In-Reply-To: <20050103205231.GK9923@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Dilger <adilger@clusterfs.com>
Cc: jthiessen@penguincomputing.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, greg@kroah.com

> Also, on a completely "I don't know what the hell I'm talking about"
> point, it seems odd that for values named "0_3" and "4_7" you would
> upshift the "4_7" value 8 bits instead of 4, but it could be just a
> bad choice of variable names.

Actually each divider is stored on 2 bits, so both the names and the
shift look OK to me.

-- 
Jean Delvare
http://khali.linux-fr.org/

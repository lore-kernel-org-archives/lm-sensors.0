From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: gl520sm bug
Message-Id: <20040509093645.0a1c78f7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073896762.40025d3a8d993@imp.gcu.info>
In-Reply-To: <1073896762.40025d3a8d993@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > i think theres a big bug in your driver
> > when i load it and run sensors my cpu fan stops
> > and it doesn't start again (tested up to 66 degree)

Fixed in CVS. The initialization was admittedly too agressive.

-- 
Jean Delvare
http://khali.linux-fr.org/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Setting vrm with 'sensors -s' is broken (w/ Linux 2.6.x)
Message-Id: <1081329157.4073c605c2b9e@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040407035157.GD6289@earth.solarsys.private>
In-Reply-To: <20040407035157.GD6289@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixing myself:

> In fact in looks like all voltage and temperatures cases are
> explicitly handled before, so just removing the offending line should
> be just find.

To be read as:

Replacing
  *sysmag = (feature->scaling=0?0:3);
with
  *sysmag = feature->scaling;
as it used to be before I broke it should fix the problem.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

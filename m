From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid, take 3
Message-Id: <20050512183226.178888da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> This small patch changes two drivers, adm1025 and adm1026, to 
> report vid as cpu0_vid sysfs name as used by the other drivers.
> 
> Added duplicated names and six month warning for old names to 
> be removed as requested.  Compile tested.
> 
> Rediff'd to 2.6.12-rc4 as requested, take 2 completely bogus, sorry.

This one works for me. Thanks.

-- 
Jean Delvare

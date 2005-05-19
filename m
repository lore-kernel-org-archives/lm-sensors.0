From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Help getting hardware monitoring on Intel 855PM 82801DBM
Message-Id: <20050422094729.53ea3ea3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1114109876.6001.26.camel@localhost.localdomain>
In-Reply-To: <1114109876.6001.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Vesko,

> Is it possible to get at least the hard drive temperature
> reported under linux?

It is, but not with lm_sensors. Try smartmontools:
  http://smartmontools.sourceforge.net/
The command:
  smartctl -A /dev/hda | grep -i temper
should give you what you want.

> PS  Is it correct that I am replying to the mailing list, rather than
> to your personal email address? 

Oh yes it is :)

-- 
Jean Delvare

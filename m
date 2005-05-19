From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: 405 i2c patch
Message-Id: <200204061615.g36GFuM02145@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CAE05EB.F2EC7BF8@paradyne.com>
In-Reply-To: <3CAE05EB.F2EC7BF8@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

phil@netroedge.com wrote:
> 
> 
> A while ago we converted any // comments to the /* */ kind.  I think
> Frodo had some good reasons for doing this, although I don't remember
> right now what they were.  Perhaps it is for compiler compatibility? 
> I guess if for nothing else, it would be nice to convert those for
> consistency sake.

// is not ISO-C. GCC accepts it, though, but some versions emit warnings,
depending on compiler flags.

  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

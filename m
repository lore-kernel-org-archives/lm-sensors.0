From: marcelo.tosatti@cyclades.com (Marcelo Tosatti)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave
Message-Id: <Pine.LNX.4.58L.0401141052590.6737@logos.cnet>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>



On Sun, 11 Jan 2004, Jean Delvare wrote:

> I will be sending 8 patches to you, based on linux-2.4.25-pre4. They
> contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
> CVS repository [1]. Since that repository was also the base of the i2c
> subsystem as is now in linux 2.6, one might also consider these patches
> as backports from linux 2.6.
>
> Details about what the patch does and credits will be found with each
> patch.

Jean,

From what I understand all patches are cleanups except the bus scanning
removal (which fixes a problem on ThinkPad?).

I want to merge only bug fixes or practical corrections.

Please correct me if I overlooked the patches and they contain bug fixes.

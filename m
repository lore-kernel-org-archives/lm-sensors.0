From: pasik@iki.fi (Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?=)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <20050227131027.GM25818@edu.joroinen.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050226191142.6288b2ef.khali@linux-fr.org>
In-Reply-To: <20050226191142.6288b2ef.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: David Hoffman <dhoffman_98@yahoo.com>

On Sat, Feb 26, 2005 at 07:11:42PM +0100, Jean Delvare wrote:
> Hi all,
> 
> I have been working on a w83627ehf hardware monitoring driver. The
> W83627EHF is a Super-I/O chip made by Winbond. Like other chips of the
> family (W83627HF, W83697HF, W83627THF...), it integrates hardware
> monitoring functions. Of these, my preliminary driver only handles
> temperature and fan inputs at the moment. I lack time and do not have
> hardware to test it, so I will not improve it significantly in a near
> future.
> 

Hi!

Do you know about driver for W83627THF watchdog? I'm using Supermicro P8SCI
motherboard, and I haven't found working driver for it..

Thanks!

-- Pasi K?rkk?inen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

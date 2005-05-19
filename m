From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [dma_k@mail.ru: Compilation question.]
Message-Id: <20040222160116.GA1032@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Dmitry Katsubo <dma_k@mail.ru> -----

From: Dmitry Katsubo <dma_k@mail.ru>
To: Frodo Looijaard <frodol@dds.nl>
Subject: Compilation question.
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

Hello, Frodo Looijaard!

I am writing to you, as to the contributor of I2C project.
I am not sure you can answer my question (if not, just tell me
whom I can ask).

The question is:

After applying i2c-2.8.4.tar.gz to linux-2.4.25 the following options are no 
longer compilable
(as they do not correspond to the new I2C interface?):

    Character devices -> I2C support -> NatSemi SCx200 I2C GPIO pins 
    (CONFIG_SCx200_I2C)
    Character devices -> I2C support -> NatSemi SCx200 ACCESS.bus 
    (CONFIG_SCx200_ACB)
    Multimedia devices -> Video For Linux -> SAA5249 Teletext processor 
    (CONFIG_VIDEO_SAA5249)
    Multimedia devices -> Video For Linux -> SAB3036 tuner 
    (CONFIG_TUNER_3036)

(files: scx200_i2c.c, scx200_acb.c, saa5249.c, tuner-3036.c).

What can be done to make them back again? Are they supported anymore?

Thanks.

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

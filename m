From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [nikkne@hotpop.com: I2C proc support for 2.5.xx]
Message-Id: <20030623114446.GB20361@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Nikola Kne?evi? <nikkne@hotpop.com> -----

From: Nikola Kne?evi? <nikkne@hotpop.com>
Reply-To: Nikola Kne?evi? <nikkne@hotpop.com>
Organization: necto
To: frodol@dds.nl
Subject: I2C proc support for 2.5.xx
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

Hi, I've noticed that the linux-kernel Documentation says there is i2c
proc/ support, but there is none. kernel tree is missing i2c-proc.[h|c]
files.
If those files shouldn't exist in kernel-tree, then the documentation
and help for CONFIG_I2C should be fixed. Otherwise, those files should
be added.

I've tried to build kernel 2.5.72, with turned on support for i2c (as
module) and /proc but there was no i2c-proc, which made sensors tool
(from working 2.4.21 instalation) totaly useless.

-- 
.. Sanjao sam da mi je WWW LAN
 
Nikola Knezevic
 [homepage: http://users.hemo.net/indy] 
 [jabberID: indy@jabber.at]


----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

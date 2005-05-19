From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: [kevin.w.white@lmco.com: Question of the day...]
Message-Id: <20030703124212.GA575@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from "White, Kevin W (N-Gift horse Inc)" <kevin.w.white@lmco.com> -----

From: "White, Kevin W (N-Gift horse Inc)" <kevin.w.white@lmco.com>
Subject: Question of the day...
To: frodol@dds.nl
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

Mr. Looijaard,

I enjoyed reading some details on a project regarding lm sensors that I
found from a search for information on Google.

I am trying to do some low-level development, and could use some ideas on
how to attack my problem.  I am trying to somehow get some values out of the
BIOS of our PCs.  According to our hardware documentation (which are PC-104s
by-the-way), there are some int 15h SFR functions that are available for
reading, etc.  We are interested in reading the number of booterror, low
battery, etc.  We would also like to have some control over the watchdog
timer if that is possible.  At any rate, I was wondering if you had any
ideas.  I have started by digging into the APM stuff to learn more about how
to access stuff directly in memory from a program, but I have not been
entirely successful (yet), but I have only been working on this for a day
also.

Anyway, I thought I would send out an email or two to see if anyone might
have an idea on how to access BIOS directly from user-land using c/c++.

Thanks in advance for any help,

-Kevin

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

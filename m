From: kai.svahn@nokia.com (Kai Svahn)
Date: Mon, 06 Mar 2006 07:15:43 +0000
Subject: [lm-sensors] i2c-core error messages
Message-Id: <20060306071543.GE16281@six.research.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

I was just wondering is there a reason that in i2c.core.c file, i2c_probe
function returns 0 when there is an error? I changed the code a bit for
my own chip driver to know that we fail and then I return
negative value.
I noticed this problem when I had HW with faulty chip that communicates
through i2c.

I can post a patch if you want.

Cheers,
Kai


From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040208231431.197d2d45.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Attached you'll find the changes for kernel 2.4.x. Updated
> documentation will follow later.

I commited your changes, with almost no changes, except rewording in
your sensors.conf comment, and mappings in the library. In your original
patch, the mappings for pwm symbols were broken (pointing to themselves,
which isn't correct).

Please check that the commited version works OK, and provide a
documentation update that reflects these changes.

I will send the 2.6 kernel driver to Greg KH in a minute.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

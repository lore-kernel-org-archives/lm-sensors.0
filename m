From: alon.keren@gmail.com (Alon Keren)
Date: Mon, 24 Apr 2006 11:31:20 +0000
Subject: [lm-sensors] Patch regarding the I2C_HEADERS variable in
Message-Id: <92c85b0e0604240431l54394a80xf6e58be07af5d32b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,
I consider the following as a nuisance, but still a bug.
I've noticed that lm_sensors's compilation always assumes that there
is a special path for i2c headers, which is held in I2C_HEADERS
(default is '/usr/local/include'). In my opinion, it should be
possible to unset that variable, in case there is no such special
path. The attached patch does exactly that.

 Alon

P.S. since I'm not subsribed to the mailing list, please CC me your replies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.10.0-i2c_headers-1.patch
Type: application/octet-stream
Size: 784 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060424/6358e2a6/lm_sensors-2.10.0-i2c_headers-1.obj

From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 04 Nov 2005 20:53:23 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <436BBC0A.9010601@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

As the last resort you can try to change the base frequencies of PWM. All you need is to look into the dataseet and find register
0x5C bank 0. Then you can use isaset command to modify the register. If you need help with this just write back.

Regards
Rudolf

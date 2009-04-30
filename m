From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 30 Apr 2009 07:21:42 +0000
Subject: Re: [lm-sensors] dme1737: Base address not set / How to do the
Message-Id: <49F95186.7040304@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <f76a32050904290817u6e296898x2fdbd43136e0d5ef@mail.gmail.com>
In-Reply-To: <f76a32050904290817u6e296898x2fdbd43136e0d5ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

If you tell me cat /proc/cpuinfo and what type of SB you have I might tell some 
IO addresses which are safe to use ;)

I think you can setup there usually something around 0x300 like 0x290. Assuming 
that the rest of superio lives at 0x2e/0x2f or so...

Btw what BIOS is that?

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

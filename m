From: roger@planbit.co.uk (Roger Lucas)
Date: Thu, 03 Nov 2005 00:26:46 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <20051102232620.4404D12E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Unfortunately, by this time of the evening I am in a similar state to you,
so I'll try this along when I do the changes from Jean's code review
(hopefully tomorrow).

- Roger

-----Original Message-----
From: Rudolf Marek [mailto:r.marek@sh.cvut.cz] 
Sent: 02 November 2005 22:09
To: lm-sensors@lm-sensors.org
Cc: Jean Delvare; roger@planbit.co.uk
Subject: Re: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE
2.6

Hello all,

Here is the first shot. I wrote it in the evening after two beers so dont
expect to be bug free ;).
On the other hand comments wellcomed. (yes I know it can be written using
ternary operator)

Roger, can you give a try if it detects your CPU and you will get back 1.2V?

TYPE  FAMILY  MODEL  STEPPING
0       6       7       0+   this should be 85? -  EDEN ESP samuel 2
0       6       7       8+   VRM85 C3 EZRA
0       6       8       0-7  VRM85 C3 EZRA T
0       6       9       0+   VRM85 NEMIAH
0       6       9       8+  max 1718 C3-M

Thanks,

Regards
Rudolf


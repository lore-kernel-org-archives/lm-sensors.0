From: cedric.pradalier@inrialpes.fr (Cedric Pradalier)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Adm1030 driver
Message-Id: <20040327134436.044c0df6.cedric.pradalier@inrialpes.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 27 Mar 2004 13:27:02 +0100, 
Jean Delvare gracefully wrote:
>
>The ADM1030 and ADM1031 are mostly compatible and belong to the same
>driver. The ADM1031 has one more temperature channel and some fan
>filtering capability.
>
>The original thread is here:
>http://archives.andrew.net.au/lm-sensors/msg00393.html
>
>I don't know if ADM finally sent the eval board to George or not. I
>tried contacting George and Aaron in November 2003 but had no reply. I
>fear we can consider them lost, and the eval board with them if there
>ever was one.
>
>So I guess we can consider Cedric's work as the only code available at
>the moment. Cedric, can you submit your work to us for a review?

Sure. The current version, which is quite limited, can be found at 
http://cedric.pradalier.free.fr/ibook2/index.html
I have the docs, so I'll be able to add functionalities if needed.

>Prefered form would be a patch against 2.6.5-rc1 or later. 
This is 2.4. But I'll try to improve.

> Make sure
>you follow the sysfs naming conventions as found in
>Documentation/i2c/sysfs-interface of the same Linux tree.

I'm sure I don't ! But since someone is interested, I'll try to adapt.

>
>Thanks.
>


-- 
Cedric

"[Of course] I'm French! Why do think I have this outrageous 
accent, you silly king-a?!"  Monty Python and the Holy Grail
